# Prerequisites

Before beginning the Linux Command Line Training course, you'll need to have access to a Linux environment. For Windows users, we recommend using Windows Subsystem for Linux (WSL) with Ubuntu. Follow these installation steps:

## System Requirements
- Windows 10 version 2004 and higher (Build 19041 and higher) or Windows 11
- Administrator access to your Windows system
- At least 4GB of free disk space

## Installation Process

### 1. Enable Windows Subsystem for Linux
1. Enable required Windows features:
    - Press Windows + R
    - Type "optionalfeatures.exe"
    - Press Enter
    - Enable:
        - Windows Subsystem for Linux
        - Virtual Machine Platform
        - SMB Direct (if available)
    - Click OK and restart when prompted

    !!! note
        These features are required for WSL to function properly. Your system will need to restart after enabling them.

### 2. Install Ubuntu
1. Open Microsoft Store
2. Search for "Ubuntu"
3. Choose a version:
    - Ubuntu (latest version)
    - Ubuntu 22.04.5 LTS (Recommended)
    - Ubuntu 20.04.6 LTS
    - Ubuntu 18.04.6 LTS

    !!! tip
        We recommend using the LTS (Long Term Support) version for stability and extended support.

### 3. Initial Setup
1. Launch Ubuntu from the Start menu
2. Wait for initial installation to complete
3. Create your UNIX user account:
    ```bash
    Enter new UNIX username: your_username
    New password: your_password
    Retype new password: your_password
    ```

    !!! warning
        - The password will not be visible as you type
        - Choose a username that is lowercase and simple
        - Use a strong password that you can remember

## Best Practices

### Username Guidelines
- Use lowercase letters only
- Avoid special characters
- Keep it simple and memorable
- Doesn't need to match Windows username

### Password Guidelines
- Use a strong combination of:
    - Uppercase letters
    - Lowercase letters
    - Numbers
    - Special characters
- Minimum 8 characters recommended
- Store securely

### System Maintenance
- Update Windows regularly
- Keep WSL features current
- Monitor available disk space
- Regular system updates

## Verification Steps

### Verify Installation
Run these commands in your Ubuntu terminal:
```bash
# Check Linux kernel version
uname -a

# Verify Ubuntu version
lsb_release -a

# Test basic commands
pwd
ls
whoami
```

### Initial System Update
After verification, update your system:
```bash
# Update package list and upgrade installed packages
sudo apt update && sudo apt upgrade
```

!!! tip "Troubleshooting"
    If you encounter issues:

    1. Verify Windows version compatibility

    2. Check Windows Features are properly enabled

    3. Run `wsl --update` in PowerShell as administrator

    4. Consult [official documentation](https://aka.ms/wslusers)

## Next Steps
After completing the installation and setup:

1. Review the course structure

2. Familiarize yourself with the terminal

3. Proceed to [Module 1: Command Line Basics](../modules/01-command-line-basics/index.md)

!!! success "Ready to Begin"
    Once you've completed these prerequisites, you're ready to start the course. If you encounter any issues, please consult the troubleshooting section or reach out for assistance.