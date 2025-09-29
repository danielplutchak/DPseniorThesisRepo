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
1. Camera is pointed at anything
2. The app outputs exposure settings that would produce a good negative.

**Alternative Courses**:
- **Step 3**: Camera is reading too little light
  1. Displays "Too little light, try pointing the camera at something brighter."

### Use Case 1.2: Standard Mode /w Locking feature
- **Actors**: User
- **Overview**: User locks a settings, then points the camera.

**Typical Course of Events**:
1. User locks one certain settings that they want to be a constant.
2. Camera is pointed at anything
3. The two remaining settings are calculated and returned

**Alternative Courses**:
- Any step: User locks two settings
  1. User locks two desired settings
  2. Camera is pointed at anything
  3. The one remaining setting is calculated and returned

### Use Case 1.3: Multiple Exposure Mode
- **Actors**: User
- **Overview**: User sets the amount of exposures, takes photos, and receives exposure settings.

**Typical Course of Events**:
1. Run Use Case 1.2, *Find a Course*.
2. Student clicks on "register for course" button.
3. Verify that student can take the course.
4. Display "You have successfully registered for 'insert course name here'."

**Alternative Courses**:
- **Step 4**: Student can't take course
  1. Displays "You cannot take this course, please contact the registrar for further information."

### Use Case 1.4: Check Grades
- **Actors**: Student
- **Overview**: Student checks grades.

**Typical Course of Events**:
1. Run Use Case 1.1, *Secure Login*.
2. Display previous semesters in which the student took course(s).
3. Student selects semester.
4. Displays courses and grades.

### Use Case 1.5: Registrar Creates Sections
- **Actors**: Registrar
- **Overview**: Registrar creates section.

**Typical Course of Events**:
1. Run Use Case 1.1, *Secure Login*.
2. Registrar selects "Create Section."
3. Display "Create Section" form.
4. Registrar submits form.
5. System verifies valid entry (no overlapping schedules/times).
6. Displays section details and successfully added.

**Alternative Courses**:
- **Step 6**: Entry invalid
  1. Display error.
  2. Go back to step 3.

### Use Case 1.6: Registrar Modifies Section
- **Actors**: Registrar
- **Overview**: Registrar modifies existing sections.

**Typical Course of Events**:
1. Run Use Case 1.1, *Secure Login*.
2. Registrar selects "Modify section."
3. Displays all sections (with order options).
4. Choose section.
5. Display "Edit Form" with filled-in data.
6. Submit/verify data.
7. Display "Section successfully edited."

**Alternative Courses**:
- **Step 7**: Invalid Data
  1. Display Error.
  2. Go back to step 5.
 
# Sample Spec

Below is an example of a project specification.  

## Software Requirements Specification for the Mahoney University Registration System

## Introduction

### Purpose
The purpose of this document is to outline the functional and non-functional requirements of Mahoney University’s new online registration system. The system is designed to streamline the registration process for students and faculty, replacing the outdated manual system. This specification serves as a contract between the system stakeholders and the developers to ensure that the system meets the needs of its users while adhering to university policies and technical constraints.

The key goals of the new system are:
- To improve the efficiency of the course registration process for students.
- To provide staff in the Registrar’s Office with tools to manage course offerings, schedules, and student records.
- To enhance the accuracy and accessibility of student academic information, such as grades and enrollment history.
- To support the university’s transition to digital infrastructure while maintaining compatibility with legacy systems during a transitional period.

### Scope
This system is intended to support the registration process for all students at Mahoney University, including undergraduates, graduate students, and non-degree-seeking students. The system will handle:
- Student authentication and secure access to personal records.
- Course search and registration.
- Enrollment validation, including prerequisite checks and course availability.
- Management of student schedules, including the ability to add, drop, or modify course enrollments.
- Grade viewing and transcript requests.

The scope of the system also includes administrative tools for the Registrar’s Office to:
- Create and modify course offerings for each academic term.
- Manage enrollment caps, waitlists, and course prerequisites.
- Track student progress and generate reports for academic performance.

### Definitions, Acronyms, and Abbreviations
- **Registrar**: The official responsible for maintaining student records, managing course schedules, and overseeing the registration process.
- **Student Information System (SIS)**: A university-wide database that stores student records, course information, and academic data.
- **GPA**: Grade Point Average, a numerical representation of a student's academic performance.
- **Semester**: A division of the academic year, typically consisting of a Fall and Spring term, in which courses are offered and completed.
- **Waitlist**: A system that allows students to reserve a spot in a full course, subject to availability if another student drops the course.
- **Prerequisite**: A course or requirement that must be completed before a student can enroll in a more advanced course.
- **User Role**: A designation for system access levels, such as student, registrar, or faculty member, each with different permissions within the system.
- **Concurrent Enrollment**: The ability for students to be enrolled in multiple courses during the same academic term.

## Overview
The Mahoney University Registration System is a web-based platform designed to automate the course registration process for students and faculty. It serves as the primary interface for students to manage their academic schedules and for university staff to oversee the course offerings and registration workflows.

### System Features:
1. **Secure Login**: Ensures that only authorized users (students, faculty, and staff) have access to the system, with user authentication based on university credentials.
2. **Course Search**: Allows students to browse available courses by department, term, and subject, with filtering options based on course availability, schedule, and prerequisites.
3. **Course Registration**: Students can add or drop courses, view class schedules, and receive notifications of any conflicts or unmet prerequisites.
4. **Grades and Transcripts**: Provides students with access to their grades from current and past semesters, as well as the ability to request official transcripts.
5. **Registrar Management Tools**: The Registrar’s Office can create, modify, and delete course sections, set enrollment limits, and manage waitlists.

The system is designed with scalability in mind, allowing it to handle thousands of students registering simultaneously during peak periods. It will integrate with the university’s existing Student Information System (SIS) and is built using modern web technologies to ensure ease of use, reliability, and performance.

The following sections detail the specific use cases that the system will support, describing how students and staff will interact with the system during typical operations.

## Use Cases

### Use Case 1.1: Secure Login
- **Actors**: Student or registrar
- **Overview**: Actor uses password to verify their identity.

**Typical Course of Events**:
1. Page prompts for username and password.
2. User enters their username and password and hits enter/login.
3. System verifies that the username and password are correct.

**Alternative Courses**:
- **Step 3**: User and/or password are not correct.
  1. Displays error.
  2. Go back to step 1.

### Use Case 1.2: Find a Course
- **Actors**: Student
- **Overview**: Student finds a desired class.

**Typical Course of Events**:
1. Run Use Case 1.1, *Secure Login*.
2. Displays list of current and upcoming semesters.
3. Student selects a semester.
4. Displays departments actively offering courses in that semester.
5. Student selects a department.
6. Displays courses of that department from that semester that are currently offered.
7. Student selects a course.
8. Displays course details.

**Alternative Courses**:
- Any step: Student can start a new search at any time
  1. Student clicks "start new search."
  2. Go back to step 2.

### Use Case 1.3: Register for a Course
- **Actors**: Student
- **Overview**: Student registers for a course.

**Typical Course of Events**:
1. Run Use Case 1.2, *Find a Course*.
2. Student clicks on "register for course" button.
3. Verify that student can take the course.
4. Display "You have successfully registered for 'insert course name here'."

**Alternative Courses**:
- **Step 4**: Student can't take course
  1. Displays "You cannot take this course, please contact the registrar for further information."

### Use Case 1.4: Check Grades
- **Actors**: Student
- **Overview**: Student checks grades.

**Typical Course of Events**:
1. Run Use Case 1.1, *Secure Login*.
2. Display previous semesters in which the student took course(s).
3. Student selects semester.
4. Displays courses and grades.

### Use Case 1.5: Registrar Creates Sections
- **Actors**: Registrar
- **Overview**: Registrar creates section.

**Typical Course of Events**:
1. Run Use Case 1.1, *Secure Login*.
2. Registrar selects "Create Section."
3. Display "Create Section" form.
4. Registrar submits form.
5. System verifies valid entry (no overlapping schedules/times).
6. Displays section details and successfully added.

**Alternative Courses**:
- **Step 6**: Entry invalid
  1. Display error.
  2. Go back to step 3.

### Use Case 1.6: Registrar Modifies Section
- **Actors**: Registrar
- **Overview**: Registrar modifies existing sections.

**Typical Course of Events**:
1. Run Use Case 1.1, *Secure Login*.
2. Registrar selects "Modify section."
3. Displays all sections (with order options).
4. Choose section.
5. Display "Edit Form" with filled-in data.
6. Submit/verify data.
7. Display "Section successfully edited."

**Alternative Courses**:
- **Step 7**: Invalid Data
  1. Display Error.
  2. Go back to step 5.

