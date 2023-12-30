# Nolvus Mod Installation Automator

## Overview

This project provides a simple automation script using AutoIt and Nolvus to streamline the process of installing mods for The Elder Scrolls V: Skyrim without the need for a Nexus Premium account. The script automates the tedious steps involved in mod installation, making it user-friendly and accessible to everyone. The code is not perfect and prone to error but it will help you speed up the process. 

## Requirements

- Ensure that AutoIt is installed on your system. You can download it from the official website.
- Script in this repo

## How to use:

- Install AutoIT
- clone the repo and put the script "nolvus.au3" in the same folder where NovlusDashboard is installed.
- Load the script in sciTE Script Editor.
- Locate your Nolvus folder and place it in this variable `Local $nolvusPath = "D:\Novalus\NolvusDashBoard.exe"`
- Optional: Change the position of your cursor if necessary:
  ```
  MouseClick("left", 1182, 570)
	MouseClick("left", 1770, 1136)
  ```
  the code above is responsible to click on the radio and resume button.
  To have the exact position of the buttons in your screen, use the AutoIT v3 window Info => Mouse tab => Position
  ![image](https://github.com/warber0x/Nolvus-Automation/assets/7810067/8d1042a1-70a2-4b71-b412-934715c18425)
  
- Build the script and run it.

## Video Tutorial
Watch this video tutorial for more info: 

## Contribution
Feel free to do whatever you want for this script. Hope that script helps you out. 
