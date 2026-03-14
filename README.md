# 🎓 College ERP System — AWS Cloud Deployment

![AWS](https://img.shields.io/badge/AWS-EC2%20%2B%20RDS-orange?logo=amazonaws)
![Python](https://img.shields.io/badge/Python-3.12-blue?logo=python)
![Flask](https://img.shields.io/badge/Flask-3.0.3-black?logo=flask)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?logo=mysql)
![Status](https://img.shields.io/badge/Status-Live-brightgreen)

A full-stack College ERP (Enterprise Resource Planning) system deployed on **AWS EC2 + RDS**, built with Python Flask backend and vanilla HTML/CSS/JS frontend.

---

## 🌍 Live Demo

```
http://65.2.144.162:5000
```

> Hosted on AWS EC2 (Mumbai Region) · Database on AWS RDS MySQL

---

## 📸 Features

- 📊 **Dashboard** — Real-time stats, department charts, fee alerts
- 👨‍🎓 **Students** — Add, view, edit, delete student records
- 👨‍🏫 **Faculty** — Manage faculty with department assignment
- 🏫 **Departments** — Department management with HoD info
- 📚 **Subjects** — Subject catalog linked to departments & faculty
- 📋 **Attendance** — Mark and track present/absent/late per student
- 📝 **Marks & Results** — Enter exam marks and grades
- 💰 **Fee Management** — Track fee collection, pending dues, record payments

---

## 🏗️ Architecture

```
Browser (Anywhere in World)
        ↓
http://13.233.94.211:5000
        ↓
┌─────────────────────────┐
│  AWS EC2 — t3.micro     │
│  Ubuntu 24.04 LTS       │
│  Python Flask (port 5000)│
│  Mumbai (ap-south-1a)   │
└──────────┬──────────────┘
           │ Port 3306 (private)
           ↓
┌─────────────────────────┐
│  AWS RDS — MySQL 8.0    │
│  db.t3.micro            │
│  college_erp database   │
│  Mumbai (ap-south-1c)   │
└─────────────────────────┘
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | HTML5, CSS3, Vanilla JavaScript |
| Backend | Python 3.12 + Flask 3.0.3 |
| Database | MySQL 8.0 (AWS RDS) |
| DB Connector | mysql-connector-python 8.4.0 |
| CORS | flask-cors 4.0.1 |
| Hosting | AWS EC2 t3.micro (Ubuntu 24.04) |
| Database Hosting | AWS RDS db.t3.micro |
| Region | ap-south-1 (Mumbai, India) |

---

## 📁 Project Structure

```
college-erp/
├── app.py                  # Flask backend — 20+ REST API endpoints
├── requirements.txt        # Python dependencies
├── templates/
│   └── index.html          # Frontend — HTML + CSS + JS (single file)
└── database/
    └── schema.sql          # MySQL schema + dummy data
```

---

## 🗄️ Database Schema

7 relational tables:

```
departments   → id, name, code, hod
students      → id, roll_no, name, email, phone, dob, dept_id, semester
faculty       → id, emp_id, name, email, dept_id, designation, qualification
subjects      → id, code, name, dept_id, semester, credits, faculty_id
attendance    → id, student_id, subject_id, date, status
marks         → id, student_id, subject_id, exam_type, marks, max_marks, grade
fees          → id, student_id, semester, amount, paid, status
```

---

## 🚀 Deployment Guide

### Prerequisites
- AWS Account (Free Tier)
- EC2 instance (t3.micro, Ubuntu 24.04)
- RDS MySQL instance (db.t3.micro)

### Step 1 — Setup RDS Database
```bash
# Import schema from your local machine
mysql -h <RDS_ENDPOINT> -u admin -p college_erp < database/schema.sql
```

### Step 2 — Setup EC2 Server
```bash
# Connect via EC2 Instance Connect, then:
sudo apt update -y
sudo apt install python3.12-venv -y

# Create project structure
mkdir -p ~/college-erp/templates ~/college-erp/database

# Setup virtual environment
python3 -m venv ~/college-erp/venv
source ~/college-erp/venv/bin/activate
pip install flask flask-cors mysql-connector-python
```

### Step 3 — Upload Files (from local machine)
```bash
scp -i "your-key.pem" app.py ubuntu@<EC2_IP>:~/college-erp/
scp -i "your-key.pem" templates/index.html ubuntu@<EC2_IP>:~/college-erp/templates/
```

### Step 4 — Configure Database Connection
Update `DB_CONFIG` in `app.py`:
```python
DB_CONFIG = {
    'host':     'your-rds-endpoint.rds.amazonaws.com',
    'user':     'admin',
    'password': 'yourpassword',
    'database': 'college_erp',
    'port':     3306,
    'autocommit': True
}
```

### Step 5 — Run Flask
```bash
cd ~/college-erp
source venv/bin/activate

# Foreground (for testing)
python3 app.py

# Background (permanent — recommended)
nohup python3 app.py > app.log 2>&1 &
```

### Step 6 — Access App
```
http://<YOUR_EC2_PUBLIC_IP>:5000
```

---

## 🔌 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/dashboard` | Stats, charts data |
| GET | `/api/students` | All students |
| POST | `/api/students` | Add student |
| PUT | `/api/students/:id` | Update student |
| DELETE | `/api/students/:id` | Delete student |
| GET | `/api/faculty` | All faculty |
| POST | `/api/faculty` | Add faculty |
| GET | `/api/departments` | All departments |
| POST | `/api/departments` | Add department |
| GET | `/api/subjects` | All subjects |
| POST | `/api/subjects` | Add subject |
| GET | `/api/attendance` | Attendance records |
| POST | `/api/attendance` | Mark attendance |
| GET | `/api/marks` | All marks |
| POST | `/api/marks` | Enter marks |
| GET | `/api/fees` | Fee records |
| PUT | `/api/fees/:id/pay` | Record payment |

---

## ☁️ AWS Resources

| Resource | Details |
|----------|---------|
| EC2 Instance | t3.micro · Ubuntu 24.04 · ap-south-1a |
| EC2 Ports Open | 22 (SSH), 80 (HTTP), 5000 (Flask) |
| RDS Instance | db.t3.micro · MySQL 8.0 · ap-south-1c |
| RDS Port Open | 3306 (MySQL) |
| Free Tier | Yes — eligible for 12 months |

---

## 📦 Local Setup (for development)

```bash
# Clone repo
git clone https://github.com/yourusername/college-erp.git
cd college-erp

# Create virtual environment
python -m venv venv
source venv/bin/activate        # Linux/Mac
venv\Scripts\activate           # Windows

# Install dependencies
pip install -r requirements.txt

# Update DB_CONFIG in app.py with your RDS endpoint

# Run locally
python app.py
# Visit: http://localhost:5000
```

---

## 📋 requirements.txt

```
flask==3.0.3
flask-cors==4.0.1
mysql-connector-python==8.4.0
```

---

## 👨‍💻 Author

**Mukund**
Deployed on AWS EC2 + RDS · Mumbai Region · March 2026

---

## 📄 License

This project is for educational purposes.
