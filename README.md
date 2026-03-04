# Pet Adoption Management System

**Course:** CS 5200 - Database Management Systems  
**Semester:** Fall 2025  
**Institution:** Northeastern University  
**Demo:** [Watch on YouTube](https://youtu.be/ynmeYsyN1vU)

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://linkedin.com/in/ruchira-karle)

---

## Overview

The Pet Adoption Management System is a command-line application built with Python and MySQL that helps animal shelters manage their day-to-day operations. The system supports the full lifecycle of pet adoption — from registering rescued animals and managing shelter capacity, to processing adoption applications and generating analytical reports.

This project was personally motivated by a lifelong love of animals and a recognition that shelters and NGOs need organized, reliable tools to manage the continuous cycle of rescue and rehoming effectively.

---

## Technical Specifications

| Component | Details |
|---|---|
| Platform | MySQL Server 8.0 and Workbench |
| Programming Language | Python 3.11.4 or higher |
| IDE | Visual Studio Code |
| Database Client | MySQL Workbench 8.0 |
| Operating System | Windows 11 |
| Interface | Command Line Interface (CLI) |
| Database Connector | PyMySQL |

### Database Objects

| Object | Count |
|---|---|
| Tables | 7 |
| Stored Procedures | 7 |
| Functions | 4 |
| Triggers | 3 |
| Scheduled Events | 1 |
| Views | 1 |

### Python Libraries

| Library | Version | Purpose |
|---|---|---|
| pymysql | 1.1.2 | Database connectivity |
| cryptography | 46.0.3 | SSL support for database connection |
| matplotlib | 3.10.7 | Data visualization and chart generation |
| pandas | 2.2.2 | Data manipulation and statistical analysis |

---

## Project Architecture

```
KarleR_project/
├── database/
│    └── KarleR_Adoption_Sys.sql       # Full database dump
├── app/
│    ├── database.py                   # Database connection layer
│    ├── crud_operations.py            # CRUD and business logic
│    ├── analytics.py                  # Reports and visualizations
│    └── main.py                       # Main entry point and CLI
└── Images                             # Screenshots of project
```

### Module Responsibilities

- **database.py** — Manages the database connection and initialization
- **crud_operations.py** — Handles all CRUD operations and business logic via stored procedures
- **analytics.py** — Generates charts and statistical reports using matplotlib and pandas
- **main.py** — Entry point for the application, handles user interaction and CLI menu

---

## Prerequisites

The following must be installed before running the application:

**MySQL Database Server (Version 8.0 or higher)**
- Download: https://dev.mysql.com/downloads/mysql/
- Verify: `mysql --version`

**Python (Version 3.11 or higher)**
- Download: https://www.python.org/downloads/
- Verify: `python --version`

**MySQL Workbench (Version 8.0 or higher)**
- Download: https://dev.mysql.com/downloads/workbench/

**Visual Studio Code (Recommended)**
- Download: https://code.visualstudio.com/

---

## Installation and Setup

### Step 1 — Install Python Libraries

Run the following in your terminal or command prompt:

```bash
pip install pymysql cryptography matplotlib pandas
```

If the above does not work, try:
```bash
pip install --user pymysql cryptography matplotlib pandas
```

For Mac users:
```bash
pip3 install pymysql cryptography matplotlib pandas
```

### Step 2 — Database Setup

1. Launch MySQL Workbench
2. Connect to your local MySQL server using your root credentials
3. Open the file: `database/pet_adoption_system.sql`
4. Execute the entire script using the lightning bolt icon
5. Verify that 7 tables have been created successfully before proceeding

### Step 3 — Configure Database Connection

1. Open the project in VS Code: **File → Open Folder → Select the `app` folder**
2. Open `database.py`
3. On line 9, update the password field with your MySQL root password:

```python
self.password = 'your_password_here'
```

4. Save the file

### Step 4 — Run the Application

Navigate to the `app` folder in your terminal and run:

```bash
cd app
python main.py
```

For Mac:
```bash
python3 main.py
```

You will see a CLI menu with options 0 through 14 to interact with the system.

> **Note:** Use Visual Studio Code or PyCharm only. Do NOT use Notepad++ or Python IDLE as they may cause issues with multi-file projects.

---

## Features

**Create Operations**
- Add new pets to the shelter
- Register new adopters
- Submit adoption applications

**Read Operations**
- View all available pets
- View all adoption applications

**Update Operations**
- Update pet information
- Update adopter information
- Process and update application status

**Delete Operations**
- Delete pets (only if not adopted)
- Delete adopter records

**Analytics and Reporting**
- Pie chart: Pet distribution by species
- Bar chart: Shelter occupancy rates across all shelters
- Line chart: Monthly adoption trends and average processing time
- Statistical summary report

> Charts are saved automatically as PNG files in the current directory: `pets_by_species.png`, `shelter_occupancy.png`, and `adoption_trends.png`. Close the chart window after viewing to continue using the application.

---

## Important Notes

- Ensure the password in `database.py` matches your MySQL root password before running
- Run the complete SQL script in Workbench and verify all tables before launching the CLI
- Auto-increment is used in the database — ID numbers may not always be sequential
- The system currently supports single-user access only
- Close chart windows after viewing, as open charts will pause the program

---

## Future Scope

- Expanded pet status tracking including Medical Hold, Deceased, and Transferred
- Medical records table for tracking vaccinations and treatments
- Payment tracking for adoption fees with integration for PayPal and card payments
- Photo storage using cloud-based solutions
- Cloud migration to platforms such as Microsoft Azure
- Donor management and day-adopter functionality with government ID verification

---

## Author

**Ruchira Ravindra Karle**  
M.S. Computer Science | Northeastern University  

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://linkedin.com/in/ruchira-karle)

---

## License

© 2025 Ruchira Ravindra Karle. All rights reserved.  
This project is made publicly available for viewing and academic reference only.  
No part of this project may be copied, modified, distributed, or used without  
explicit written permission from the author.
