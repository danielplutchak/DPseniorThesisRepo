# Senior Thesis Repo: Light Meter App
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

A light meter is useful to me because the film cameras I own do not have built-in light meters, so for every photo, I need to manually set the exposure settings. When I'm outside during a sunny day, this it isn't a problem since I know what settings will produce a good exposure. However, when I want to take a photo during inclement weather conditions or indoors, it is often hard to tell what settings to use. A light meter is the solution for this, as it can tell the user what would be the best settings use for any given lighting condition.

The problem is, I have an iPhone, and all the light meter apps on the iOS App Store require some sort of payment, whether it is an up-front payment or a free app with features locked behind a paid subscription. To solve this problem, I am making my own light meter app for personal use, so I do not need to pay to use this extremely helpful tool.

### Purpose

The purpose of this document is to outline the functional and non-functional requirements of the Light Meter app. This app will be designed to be an easy-access light meter that aids the user by outputting precise exposure settings to use when shooting a photo on a camera.

The key goals of this app are:
- To offer an easy-access light meter for shooting on an analog camera, or digital camera if desired.
- To output accurate exposure settings with functionality to lock shutter speed, aperture, and ISO settings.
- To have a straight-forward, easy to use design

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
- **EV**: Stands for "exposure value," a value that represents the combination of the shutter speed and aperature settings that create a specific exposure.
- **Exposure Triangle**:

## Overview
Light Meter is an IOS app designed to provide a fast and efficient output of what camera settings would be appropriate for the what the camera is pointing at.

### System Features:
1. **Camera Display**: The app features a camera preview so the user can see what the camera is pointing at, and know what lighting conditions the program is reading in.
2. **Unlock Settings**: The user can choose one setting to be unlocked, which makes the other two settings locked.
3. **Set Locked Settings**: The user can set the two locked settings to be specific values they want to shoot thier photos with, which will affect the output of the unlocked setting.
4. **Output Unlocked Setting Value**: Given the camera input and the set values of the locked settings, the program will output a value for a proper exposure for the unlocked setting.

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
