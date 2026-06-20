-- ============================================================
--MCA Result Management System - Complete Schema
-- genba sopanrao moze college of engineeringe Pune | Faculty:MCA
-- ============================================================

-- Master admin table
CREATE TABLE IF NOT EXISTS admins (
    id         UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name       TEXT NOT NULL,
    email      TEXT UNIQUE NOT NULL,
    password   TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Teachers table
CREATE TABLE IF NOT EXISTS teachers (
    id         UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name       TEXT NOT NULL,
    email      TEXT UNIQUE NOT NULL,
    password   TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Students table — class is one of: FYMCA | SYMCA | TYMCA
--                  semester is 1 or 2 within that class
CREATE TABLE IF NOT EXISTS students (
    id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name        TEXT NOT NULL,
    roll_number TEXT UNIQUE NOT NULL,
    email       TEXT NOT NULL,
    password    TEXT NOT NULL,
    class       TEXT NOT NULL CHECK (class IN ('FYMCA','SYMCA','TYMCA')),
    semester    INTEGER NOT NULL CHECK (semester IN (1,2)),
    created_at  TIMESTAMPTZ DEFAULT now()
);

-- Subjects table — each subject belongs to one class + semester
--   teacher_id is optional (assigned by admin); one subject = one teacher max
CREATE TABLE IF NOT EXISTS subjects (
    id           UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    subject_name TEXT NOT NULL,
    class        TEXT NOT NULL CHECK (class IN ('FYMCA','SYMCA','TYMCA')),
    semester     INTEGER NOT NULL CHECK (semester IN (1,2)),
    max_marks    INTEGER DEFAULT 100,
    teacher_id   UUID REFERENCES teachers(id) ON DELETE SET NULL,
    sort_order   INTEGER DEFAULT 0,
    created_at   TIMESTAMPTZ DEFAULT now(),
    UNIQUE(subject_name, class, semester)
);

-- Marks — one row per student per subject
CREATE TABLE IF NOT EXISTS marks (
    id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    student_id  UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    subject_id  UUID NOT NULL REFERENCES subjects(id) ON DELETE CASCADE,
    score       NUMERIC(6,2) DEFAULT NULL,
    entered_by  UUID REFERENCES teachers(id) ON DELETE SET NULL,
    entered_at  TIMESTAMPTZ DEFAULT now(),
    UNIQUE(student_id, subject_id)
);

-- Results — one row per student (published flag per student)
CREATE TABLE IF NOT EXISTS results (
    id           UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    student_id   UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE UNIQUE,
    total_marks  NUMERIC(8,2) DEFAULT 0,
    max_marks    NUMERIC(8,2) DEFAULT 0,
    percentage   NUMERIC(5,2) DEFAULT 0,
    grade        TEXT DEFAULT 'F',
    published    BOOLEAN DEFAULT false,
    published_at TIMESTAMPTZ,
    created_at   TIMESTAMPTZ DEFAULT now()
);

-- ============================================================
-- ROW LEVEL SECURITY — open policies for anon key access
-- ============================================================
ALTER TABLE admins   ENABLE ROW LEVEL SECURITY;
ALTER TABLE teachers ENABLE ROW LEVEL SECURITY;
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
ALTER TABLE subjects ENABLE ROW LEVEL SECURITY;
ALTER TABLE marks    ENABLE ROW LEVEL SECURITY;
ALTER TABLE results  ENABLE ROW LEVEL SECURITY;

CREATE POLICY "admins_all"   ON admins   FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "teachers_all" ON teachers FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "students_all" ON students FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "subjects_all" ON subjects FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "marks_all"    ON marks    FOR ALL TO anon USING (true) WITH CHECK (true);
CREATE POLICY "results_all"  ON results  FOR ALL TO anon USING (true) WITH CHECK (true);

-- ============================================================
-- SEED DATA
-- ============================================================

-- Master admin
INSERT INTO admins (name, email, password)
VALUES ('Master Admin', 'admin@gsmoze.edu', 'admin123')
ON CONFLICT (email) DO NOTHING;

-- Default subjects — FYMCA Semester 1
INSERT INTO subjects (subject_name, class, semester, max_marks, sort_order) VALUES
  ('Introduction to Programming',  'FYMCA', 1, 100, 1),
  ('Mathematics I',                 'FYMCA', 1, 100, 2),
  ('Digital Electronics',           'FYMCA', 1, 100, 3),
  ('Communication Skills',          'FYMCA', 1, 100, 4),
  ('Environmental Science',         'FYMCA', 1, 100, 5)
ON CONFLICT (subject_name, class, semester) DO NOTHING;

-- FYMCA Semester 2
INSERT INTO subjects (subject_name, class, semester, max_marks, sort_order) VALUES
  ('C Programming',                 'FYMCA', 2, 100, 1),
  ('Mathematics II',                'FYMCA', 2, 100, 2),
  ('Web Technology Basics',         'FYMCA', 2, 100, 3),
  ('Computer Organisation',         'FYMCA', 2, 100, 4),
  ('Soft Skills',                   'FYMCA', 2, 100, 5)
ON CONFLICT (subject_name, class, semester) DO NOTHING;

-- SYMCA Semester 1
INSERT INTO subjects (subject_name, class, semester, max_marks, sort_order) VALUES
  ('Data Structures',               'SYMCA', 1, 100, 1),
  ('Database Management Systems',   'SYMCA', 1, 100, 2),
  ('Object Oriented Programming',   'SYMCA', 1, 100, 3),
  ('Operating Systems',             'SYMCA', 1, 100, 4),
  ('Discrete Mathematics',          'SYMCA', 1, 100, 5)
ON CONFLICT (subject_name, class, semester) DO NOTHING;

-- SYMCA Semester 2
INSERT INTO subjects (subject_name, class, semester, max_marks, sort_order) VALUES
  ('Advanced Java',                 'SYMCA', 2, 100, 1),
  ('Computer Networks',             'SYMCA', 2, 100, 2),
  ('Software Engineering',          'SYMCA', 2, 100, 3),
  ('Web Development',               'SYMCA', 2, 100, 4),
  ('Statistics for CS',             'SYMCA', 2, 100, 5)
ON CONFLICT (subject_name, class, semester) DO NOTHING;

-- TYMCA Semester 1
INSERT INTO subjects (subject_name, class, semester, max_marks, sort_order) VALUES
  ('Machine Learning',              'TYMCA', 1, 100, 1),
  ('Cloud Computing',               'TYMCA', 1, 100, 2),
  ('Cyber Security',                'TYMCA', 1, 100, 3),
  ('Mobile Application Development','TYMCA', 1, 100, 4),
  ('Big Data Analytics',            'TYMCA', 1, 100, 5)
ON CONFLICT (subject_name, class, semester) DO NOTHING;

-- TYMCA Semester 2
INSERT INTO subjects (subject_name, class, semester, max_marks, sort_order) VALUES
  ('Artificial Intelligence',       'TYMCA', 2, 100, 1),
  ('Blockchain Technology',         'TYMCA', 2, 100, 2),
  ('Internet of Things',            'TYMCA', 2, 100, 3),
  ('Project Management',            'TYMCA', 2, 100, 4),
  ('Final Year Project',            'TYMCA', 2, 100, 5)
ON CONFLICT (subject_name, class, semester) DO NOTHING;
