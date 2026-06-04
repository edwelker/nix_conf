#!/usr/bin/env python3
import sys
import os
import subprocess
import re
import urllib.request
import urllib.error
import json

# ANSI color codes
COLOR_RESET = "\033[0m"
COLOR_MODEL = "\033[1;32m"      # Bold Green
COLOR_MODE = "\033[1;36m"       # Bold Cyan
COLOR_QUOTA = "\033[1;33m"      # Bold Yellow
COLOR_DIM = "\033[90m"          # Dark Grey
COLOR_ALERT = "\033[1;31m"      # Bold Red
COLOR_SEP = "\033[37m"          # White separator

def get_ls_info():
    """Finds the port and csrf token of the running language server."""
    try:
        # Run ps with auxww to get wide/untruncated output on macOS
        output = subprocess.check_output(["ps", "auxww"]).decode("utf-8", errors="ignore")
    except Exception:
        return None, None

    for line in output.splitlines():
        if "language_server" in line and "csrf_token" in line:
            port_match = re.search(r"--port\s+(\d+)", line)
            token_match = re.search(r"--csrf_token\s+([^\s]+)", line)
            if port_match and token_match:
                return port_match.group(1), token_match.group(1)
    return None, None

def get_quota_info(port, token):
    """Queries the language server to get user status and quota info."""
    url = f"http://127.0.0.1:{port}/exa.language_server_pb.LanguageServerService/GetUserStatus"
    req = urllib.request.Request(
        url,
        data=b"{}",
        headers={
            "Content-Type": "application/json",
            "Connect-Protocol-Version": "1",
            "X-Codeium-Csrf-Token": token
        },
        method="POST"
    )
    try:
        with urllib.request.urlopen(req, timeout=1.0) as response:
            return json.loads(response.read().decode("utf-8", errors="ignore"))
    except Exception:
        return None

def format_number(val_str):
    """Formats large numbers nicely (e.g., 245000 -> 245k)."""
    try:
        val = int(val_str)
        if val >= 1000000:
            return f"{val / 1000000:.1f}M"
        elif val >= 1000:
            return f"{val / 1000:.0f}k"
        return str(val)
    except Exception:
        return val_str

def main():
    # 1. Parse incoming metadata from stdin (sent by Antigravity CLI)
    model_name = "Unknown Model"
    cwd = "."
    try:
        # Try non-blocking read or check if stdin has data
        if not sys.stdin.isatty():
            input_data = sys.stdin.read()
            if input_data:
                data = json.loads(input_data)
                model_name = data.get("model", {}).get("display_name", model_name)
                cwd = data.get("cwd", cwd)
    except Exception:
        pass

    # Clean up model name display
    model_name = model_name.replace(" (Medium)", "").replace(" (Large)", "")

    # 2. Get quota and mode information from the local language server
    port, token = get_ls_info()
    quota_str = ""
    mode_str = ""

    if port and token:
        user_status = get_quota_info(port, token)
        if user_status:
            quota_info = user_status.get("quotaInfo", {})
            
            # Format Mode
            mode = quota_info.get("mode", "")
            if mode:
                # Clean up mode name
                mode_clean = mode.replace("QUOTA_MODE_", "").replace("_", " ").title()
                mode_str = f"{COLOR_MODE}{mode_clean}{COLOR_RESET}"
            
            # Format Quota usage
            usage = quota_info.get("totalUsage")
            limit = quota_info.get("limit")
            if usage is not None and limit is not None:
                try:
                    usage_int = int(usage)
                    limit_int = int(limit)
                    pct = (usage_int / limit_int) * 100 if limit_int > 0 else 0
                    
                    # Choose quota color based on percentage usage
                    q_color = COLOR_QUOTA
                    if pct > 85:
                        q_color = COLOR_ALERT
                    
                    quota_str = f"{q_color}{format_number(usage)}{COLOR_RESET}{COLOR_DIM}/{COLOR_RESET}{format_number(limit)} {COLOR_DIM}({pct:.1f}%){COLOR_RESET}"
                except Exception:
                    quota_str = f"{format_number(usage)}/{format_number(limit)}"

    # 3. Assemble and output the status line
    parts = []
    
    # Model
    parts.append(f"{COLOR_MODEL}{model_name}{COLOR_RESET}")
    
    # Mode
    if mode_str:
        parts.append(f"mode: {mode_str}")
        
    # Quota
    if quota_str:
        parts.append(f"quota: {quota_str}")
        
    # Build status string
    status_line = f" {COLOR_SEP}•{COLOR_RESET} ".join(parts)
    sys.stdout.write(status_line + "\n")

if __name__ == "__main__":
    main()
