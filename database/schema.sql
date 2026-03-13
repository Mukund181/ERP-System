-- ============================================================
--  COLLEGE ERP SYSTEM — MySQL Schema + Dummy Data
--  Run this on your AWS RDS MySQL instance
-- ============================================================

CREATE DATABASE IF NOT EXISTS college_erp;
USE college_erp;

-- ─────────────────────────────────────────
-- 1. DEPARTMENTS
-- ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS departments (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    code        VARCHAR(10)  NOT NULL UNIQUE,
    hod         VARCHAR(100),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO departments (name, code, hod) VALUES
('Computer Science & Engineering', 'CSE', 'Dr. Priya Sharma'),
('Electronics & Communication',    'ECE', 'Dr. Rajesh Kumar'),
('Mechanical Engineering',         'ME',  'Dr. Anil Verma'),
('Civil Engineering',              'CE',  'Dr. Sunita Patil'),
('Information Technology',         'IT',  'Dr. Meera Nair');

-- ─────────────────────────────────────────
-- 2. STUDENTS
-- ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS students (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    roll_no       VARCHAR(20)  NOT NULL UNIQUE,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    phone         VARCHAR(15),
    dept_id       INT,
    semester      INT          CHECK (semester BETWEEN 1 AND 8),
    dob           DATE,
    address       TEXT,
    status        ENUM('active','inactive') DEFAULT 'active',
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dept_id) REFERENCES departments(id) ON DELETE SET NULL
);

INSERT INTO students (roll_no, name, email, phone, dept_id, semester, dob, address) VALUES
('CSE2101', 'Aarav Mehta',     'aarav.mehta@college.edu',    '9876543210', 1, 3, '2003-04-12', 'Mumbai, MH'),
('CSE2102', 'Sneha Patel',     'sneha.patel@college.edu',    '9876543211', 1, 3, '2003-07-22', 'Pune, MH'),
('CSE2103', 'Riya Sharma',     'riya.sharma@college.edu',    '9876543212', 1, 5, '2002-01-15', 'Nagpur, MH'),
('ECE2101', 'Karan Singh',     'karan.singh@college.edu',    '9876543213', 2, 3, '2003-09-30', 'Delhi, DL'),
('ECE2102', 'Pooja Reddy',     'pooja.reddy@college.edu',    '9876543214', 2, 5, '2002-11-08', 'Hyderabad, TS'),
('ME2101',  'Arjun Nair',      'arjun.nair@college.edu',     '9876543215', 3, 3, '2003-03-18', 'Kochi, KL'),
('ME2102',  'Divya Joshi',     'divya.joshi@college.edu',    '9876543216', 3, 1, '2004-06-25', 'Jaipur, RJ'),
('CE2101',  'Rahul Verma',     'rahul.verma@college.edu',    '9876543217', 4, 7, '2001-12-05', 'Lucknow, UP'),
('IT2101',  'Ananya Iyer',     'ananya.iyer@college.edu',    '9876543218', 5, 3, '2003-05-14', 'Chennai, TN'),
('IT2102',  'Vikram Desai',    'vikram.desai@college.edu',   '9876543219', 5, 5, '2002-08-29', 'Ahmedabad, GJ');

-- ─────────────────────────────────────────
-- 3. FACULTY
-- ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS faculty (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    emp_id        VARCHAR(20)  NOT NULL UNIQUE,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    phone         VARCHAR(15),
    dept_id       INT,
    designation   VARCHAR(100),
    qualification VARCHAR(100),
    status        ENUM('active','inactive') DEFAULT 'active',
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dept_id) REFERENCES departments(id) ON DELETE SET NULL
);

INSERT INTO faculty (emp_id, name, email, phone, dept_id, designation, qualification) VALUES
('FAC001', 'Dr. Priya Sharma',  'priya.sharma@college.edu',  '9111111101', 1, 'Professor & HOD',    'Ph.D. CS'),
('FAC002', 'Prof. Suresh Rao',  'suresh.rao@college.edu',    '9111111102', 1, 'Associate Professor', 'M.Tech CS'),
('FAC003', 'Dr. Rajesh Kumar',  'rajesh.kumar@college.edu',  '9111111103', 2, 'Professor & HOD',    'Ph.D. ECE'),
('FAC004', 'Prof. Deepa Nair',  'deepa.nair@college.edu',    '9111111104', 2, 'Assistant Professor', 'M.E. ECE'),
('FAC005', 'Dr. Anil Verma',    'anil.verma@college.edu',    '9111111105', 3, 'Professor & HOD',    'Ph.D. Mech'),
('FAC006', 'Dr. Sunita Patil',  'sunita.patil@college.edu',  '9111111106', 4, 'Professor & HOD',    'Ph.D. Civil'),
('FAC007', 'Dr. Meera Nair',    'meera.nair@college.edu',    '9111111107', 5, 'Professor & HOD',    'Ph.D. IT');

-- ─────────────────────────────────────────
-- 4. SUBJECTS
-- ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS subjects (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    code        VARCHAR(20)  NOT NULL UNIQUE,
    name        VARCHAR(150) NOT NULL,
    dept_id     INT,
    semester    INT,
    credits     INT DEFAULT 3,
    faculty_id  INT,
    FOREIGN KEY (dept_id)    REFERENCES departments(id) ON DELETE SET NULL,
    FOREIGN KEY (faculty_id) REFERENCES faculty(id)     ON DELETE SET NULL
);

INSERT INTO subjects (code, name, dept_id, semester, credits, faculty_id) VALUES
('CSE301', 'Data Structures & Algorithms',  1, 3, 4, 2),
('CSE302', 'Database Management Systems',   1, 3, 3, 1),
('CSE501', 'Machine Learning',              1, 5, 4, 1),
('CSE502', 'Computer Networks',             1, 5, 3, 2),
('ECE301', 'Digital Electronics',           2, 3, 4, 4),
('ECE501', 'VLSI Design',                   2, 5, 4, 3),
('ME301',  'Thermodynamics',                3, 3, 4, 5),
('CE701',  'Structural Engineering',        4, 7, 4, 6),
('IT301',  'Web Technologies',              5, 3, 3, 7),
('IT501',  'Cloud Computing',               5, 5, 4, 7);

-- ─────────────────────────────────────────
-- 5. ATTENDANCE
-- ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS attendance (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    student_id  INT NOT NULL,
    subject_id  INT NOT NULL,
    date        DATE NOT NULL,
    status      ENUM('present','absent','late') DEFAULT 'present',
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
);

INSERT INTO attendance (student_id, subject_id, date, status) VALUES
(1, 1, '2024-07-01', 'present'), (1, 1, '2024-07-02', 'present'), (1, 1, '2024-07-03', 'absent'),
(1, 2, '2024-07-01', 'present'), (1, 2, '2024-07-02', 'late'),
(2, 1, '2024-07-01', 'present'), (2, 1, '2024-07-02', 'absent'), (2, 1, '2024-07-03', 'present'),
(3, 3, '2024-07-01', 'present'), (3, 3, '2024-07-02', 'present'),
(4, 5, '2024-07-01', 'present'), (4, 5, '2024-07-02', 'present'), (4, 5, '2024-07-03', 'late'),
(5, 6, '2024-07-01', 'absent'),  (5, 6, '2024-07-02', 'present'),
(6, 7, '2024-07-01', 'present'), (7, 7, '2024-07-01', 'present'),
(8, 8, '2024-07-01', 'present'), (9, 9, '2024-07-01', 'present'), (10,10,'2024-07-01','present');

-- ─────────────────────────────────────────
-- 6. MARKS / RESULTS
-- ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS marks (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    student_id  INT NOT NULL,
    subject_id  INT NOT NULL,
    exam_type   ENUM('internal','midterm','final') DEFAULT 'internal',
    marks       DECIMAL(5,2),
    max_marks   DECIMAL(5,2) DEFAULT 100,
    grade       VARCHAR(3),
    UNIQUE KEY uniq_mark (student_id, subject_id, exam_type),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
);

INSERT INTO marks (student_id, subject_id, exam_type, marks, max_marks, grade) VALUES
(1, 1, 'internal', 82, 100, 'A'),  (1, 1, 'final', 78, 100, 'B+'),
(1, 2, 'internal', 90, 100, 'A+'), (1, 2, 'final', 88, 100, 'A'),
(2, 1, 'internal', 74, 100, 'B+'), (2, 1, 'final', 70, 100, 'B'),
(3, 3, 'internal', 95, 100, 'A+'), (3, 4, 'internal', 88, 100, 'A'),
(4, 5, 'internal', 79, 100, 'B+'), (5, 6, 'internal', 85, 100, 'A'),
(6, 7, 'internal', 72, 100, 'B'),  (7, 7, 'internal', 68, 100, 'B'),
(8, 8, 'internal', 91, 100, 'A+'), (9, 9, 'internal', 76, 100, 'B+'),
(10,10,'internal', 83, 100, 'A');

-- ─────────────────────────────────────────
-- 7. FEES
-- ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS fees (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    student_id  INT NOT NULL,
    amount      DECIMAL(10,2) NOT NULL,
    paid        DECIMAL(10,2) DEFAULT 0,
    due_date    DATE,
    paid_date   DATE,
    status      ENUM('paid','pending','partial') DEFAULT 'pending',
    semester    INT,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

INSERT INTO fees (student_id, amount, paid, due_date, paid_date, status, semester) VALUES
(1,  75000, 75000, '2024-06-30', '2024-06-20', 'paid',    3),
(2,  75000, 75000, '2024-06-30', '2024-06-25', 'paid',    3),
(3,  75000, 40000, '2024-06-30', NULL,          'partial', 5),
(4,  70000, 70000, '2024-06-30', '2024-06-18', 'paid',    3),
(5,  70000,     0, '2024-06-30', NULL,          'pending', 5),
(6,  65000, 65000, '2024-06-30', '2024-07-01', 'paid',    3),
(7,  65000,     0, '2024-06-30', NULL,          'pending', 1),
(8,  60000, 60000, '2024-06-30', '2024-06-10', 'paid',    7),
(9,  72000, 72000, '2024-06-30', '2024-06-22', 'paid',    3),
(10, 72000, 30000, '2024-06-30', NULL,          'partial', 5);