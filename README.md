# Senior Thesis Repo: Multi Light Meter App
This repository is provided to help you build your senior thesis project. You will edit it to store your specification documents, code, and weekly checkins.

First, fork this repo (this makes a copy of it associated with your account) and then clone it to your machine (this makes a copy of your fork on your personal machine). You can then use an editor and a GitHub client to manage the repository.

### Markdown
This file is called README.md. It is a [Markdown file](https://en.wikipedia.org/wiki/Markdown). Markdown is a simple way to format documents. When a Markdown-ready viewer displays the contents of a file, it formats it to look like HTML. However, Markdown is significantly easier to write than HTML. VSCode supports displaying Markdown in a preview window. GitHub uses Markdown extensively including in every repo's description file, ```README.md```.

All Markdown files end with the extension ```.md```. There is a Markdown tutorial [here](https://www.markdowntutorial.com/) and a Markdown cheatsheet [here](https://www.markdownguide.org/cheat-sheet/).

#### Images
If you would like to add images to a Markdown file, place them in the ```docs/images/``` directory in this repo and reference them using markdown like this:

```
![alt text](relative/path/to/image)
```

Here is how to add the Carthage logo to a Markdown file (you can see the image in the repo right now):

```
![Carthage Firebird Logo](docs/images/firebirdLogo.jpg)
```
![Carthage Firebird Logo](docs/images/firebirdLogo.jpg)

This ensures that images are correctly linked and displayed when viewing the documentation on GitHub or any Markdown-supported platform.

## Code
The ```code``` directory is used to store your code. You can put it all in one directory or you can create subdirectories.

I have added a ```main.cpp``` file to get you started. Feel free to remove it.

If you have any questions feel free to ask me! I'll answer professor questions, customer questions, and give advice if asked.

# Software Requirements Specification for Multi Light Meter App

## Introduction

Along with computer science, another one of my passions is analog photography. I love shooting photos on film and the process of developing film and creating prints in the darkroom. When shooting film, an extremely useful tool I use often is a light meter. This tool tells you what settings you could set on your camera to produce a negative that has good exposure.

When shooting film, I sometimes like to take multiple exposures onto one negative to create an overlay-type effect. Since multiple exposures mean that more light will be exposed to the negative, the settings on the camera need to be different to accommodate. Standard light meters do not have any functionality for multiple exposures, so it can be diffucult to find "correct" exposure settings. To fix this issue, I will create a light meter app that not only acts as a standard meter, but also will have addiontial functionality for double exposures.

### Purpose

The purpose of this document is to outline the functional and non-functional requirements of the Multi Light Meter app. This app will be designed to be an easy-access light meter that aids the user by outputting precise exposure settings to use when shooting a photo on a camera.

The key goals of this app are:
- To offer an easy-access light meter for shooting on an analog camera, or digital camera if desired.
- To output accurate exposure settings with functionality to lock shutter speed, aperture, and ISO settings.
- To provide additional functionality for photos utilizing multiple exposures.

### Scope
This app is intended to function by using information from the camera and creating an output that shows proper exposure settings. The app will handle:
- Attaining light values from the IOS devices' built-in camera.
- Calculating proper exposure settings derived from the camera's light value.
- Outputting settings that are accurate with locked parameters and a set amount of exposures.

### Definitions, Acronyms, and Abbreviations
- **Analog Camera**: A camera that is designed to expose film, as opposed to a digital camera.
- **LUX Value**: A unit value that is used to measure the amount of light that falls on objects.
- **Exposure Settings**: The three settings on a camera that detemine how bright or dark an image will be (shutter speed, aperture, and ISO).
- **Shutter Speed**: The amount of time a cameras' sensor or film is exposed to light, measured in fractions of a second. The faster the shutter speed, the darker the photo is.
- **Aperture**: How small or large the opening of the camera lens is, measured in f-stop. The larger the opening, the brighter the photo is. Also controls the depth of field.
- **f-stop**: A measure of how small or large the aperture is. The smaller the f-stop, the larger the aperture.
- **ISO**: Stands for “International Organisation for Standardisation.” A measurement that describes the "speed" of the film. The higher the ISO, the brighter and grainer the image will be.

## Overview
The Mahoney University Registration System is a web-based platform designed to automate the course registration process for students and faculty. It serves as the primary interface for students to manage their academic schedules and for university staff to oversee the course offerings and registration workflows.

The Multi Light Meter app is an IOS app designed to provide a fast and efficient output of what camera settings would be appropriate for the what the camera is pointing at.

### System Features:
1. **Standard Mode**: Allows the user to point the phones' camera and receive exposure settings that produce a properly-exposed photo
2. **Lock Feature**: The user can lock any of the three settings, and the light meter will output the other setting(s) that will give a proper exposure along with the locked value.
3. **Multiple Exposure Mode**: Allows the user to set number of exposures, takes photos to save the light values, and will give suitable exposure settings for the multiple exposures.

## Use Cases

### Use Case 1.1: Standard Mode
- **Actors**: User
- **Overview**: User receives exposure settings corresponding to the light value the camera reads.

**Typical Course of Events**:
1. Camera is pointed at something
2. The app outputs exposure settings that would produce a good negative.

**Alternative Courses**:
- **Step 1**: Camera is reading too little light
  1. Displays: "Too little light, try pointing the camera at something brighter."

### Use Case 1.2: Standard Mode /w Locking feature
- **Actors**: User
- **Overview**: User locks a settings, then points the camera.

**Typical Course of Events**:
1. User locks one certain settings that they want to be a constant.
2. Camera is pointed at something
3. The two remaining settings are calculated and returned

**Alternative Courses**:
- **Step 1**: User locks two settings
  1. Camera is pointed at something
  2. The one remaining setting is calculated and returned

### Use Case 1.3: Multiple Exposure Mode
- **Actors**: User
- **Overview**: User sets the amount of exposures, takes photos, and receives exposure settings.

**Typical Course of Events**:
1. User selects how many exposures they plan to take
2. The user shoots photos with the phone's camera
3. The app will prompt if any settings should be locked for all exposures
4. The app will prompt if the user want each exposure to be appear thinner or thicker in the final print
5. The app will output camera settings for each exposure

**Alternative Courses**:
- **Step 2**: A photo that was shot was too dark
  1. Displays: "Too little light, try taking a photo of something brighter."
  2. The user will take a different photo with more light
