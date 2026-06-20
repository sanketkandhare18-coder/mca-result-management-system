# test_login.py — Login Tests for MCA Result Management System
# Tests: Admin Login, Teacher Login, Student Login

import pytest
from selenium.webdriver.common.by import By
import time
import os

# Base URL — your project folder path
BASE = "file:///" + os.path.dirname(os.path.dirname(os.path.abspath(__file__))).replace("\\", "/")

# =============================================
# ADMIN LOGIN TESTS
# =============================================

def test_admin_valid_login(driver):
    """Admin can login with correct email and password"""
    driver.get(BASE + "/admin-login.html")
    driver.find_element(By.ID, "adminEmail").send_keys("admin@gsmoze.edu")
    driver.find_element(By.ID, "adminPassword").send_keys("admin123")
    driver.find_element(By.ID, "loginBtn").click()
    time.sleep(2)
    assert "admin.html" in driver.current_url

def test_admin_invalid_login(driver):
    """Admin login fails with wrong password"""
    driver.get(BASE + "/admin-login.html")
    driver.find_element(By.ID, "adminEmail").send_keys("admin@gsmoze.edu")
    driver.find_element(By.ID, "adminPassword").send_keys("wrongpassword")
    driver.find_element(By.ID, "loginBtn").click()
    time.sleep(2)
    error = driver.find_element(By.ID, "loginError")
    assert error.is_displayed()

def test_admin_empty_fields(driver):
    """Admin login blocked when fields are empty"""
    driver.get(BASE + "/admin-login.html")
    driver.find_element(By.ID, "loginBtn").click()
    time.sleep(1)
    error = driver.find_element(By.ID, "loginError")
    assert error.is_displayed()

def test_admin_empty_password(driver):
    """Admin login blocked when password is empty"""
    driver.get(BASE + "/admin-login.html")
    driver.find_element(By.ID, "adminEmail").send_keys("admin@gsmoze.edu")
    driver.find_element(By.ID, "loginBtn").click()
    time.sleep(1)
    error = driver.find_element(By.ID, "loginError")
    assert error.is_displayed()

# =============================================
# TEACHER LOGIN TESTS
# =============================================

def test_teacher_empty_fields(driver):
    """Teacher login blocked when fields are empty"""
    driver.get(BASE + "/teacher-login.html")
    driver.find_element(By.ID, "loginBtn").click()
    time.sleep(1)
    error = driver.find_element(By.ID, "loginError")
    assert error.is_displayed()

def test_teacher_invalid_login(driver):
    """Teacher login fails with wrong credentials"""
    driver.get(BASE + "/teacher-login.html")
    driver.find_element(By.ID, "teacherEmail").send_keys("wrong@gsmoze.edu")
    driver.find_element(By.ID, "teacherPassword").send_keys("wrongpass")
    driver.find_element(By.ID, "loginBtn").click()
    time.sleep(2)
    error = driver.find_element(By.ID, "loginError")
    assert error.is_displayed()

def test_teacher_empty_password(driver):
    """Teacher login blocked when password is empty"""
    driver.get(BASE + "/teacher-login.html")
    driver.find_element(By.ID, "teacherEmail").send_keys("teacher@gsmoze.edu")
    driver.find_element(By.ID, "loginBtn").click()
    time.sleep(1)
    error = driver.find_element(By.ID, "loginError")
    assert error.is_displayed()

# =============================================
# STUDENT LOGIN TESTS
# =============================================

def test_student_empty_fields(driver):
    """Student login blocked when fields are empty"""
    driver.get(BASE + "/student-login.html")
    driver.find_element(By.ID, "loginBtn").click()
    time.sleep(1)
    error = driver.find_element(By.ID, "loginError")
    assert error.is_displayed()

def test_student_invalid_login(driver):
    """Student login fails with wrong roll number"""
    driver.get(BASE + "/student-login.html")
    driver.find_element(By.ID, "rollNumber").send_keys("MCA999")
    driver.find_element(By.ID, "studentPassword").send_keys("wrongpass")
    driver.find_element(By.ID, "loginBtn").click()
    time.sleep(2)
    error = driver.find_element(By.ID, "loginError")
    assert error.is_displayed()

def test_student_empty_password(driver):
    """Student login blocked when password is empty"""
    driver.get(BASE + "/student-login.html")
    driver.find_element(By.ID, "rollNumber").send_keys("MCA001")
    driver.find_element(By.ID, "loginBtn").click()
    time.sleep(1)
    error = driver.find_element(By.ID, "loginError")
    assert error.is_displayed()

# =============================================
# HOME PAGE TESTS
# =============================================

def test_home_page_loads(driver):
    """Home page loads successfully"""
    driver.get(BASE + "/index.html")
    assert "Result Management" in driver.title

def test_home_page_has_three_login_cards(driver):
    """Home page shows Admin, Teacher and Student login cards"""
    driver.get(BASE + "/index.html")
    cards = driver.find_elements(By.CLASS_NAME, "login-card")
    assert len(cards) >= 3

def test_admin_login_link_works(driver):
    """Clicking Admin Login card goes to admin-login.html"""
    driver.get(BASE + "/index.html")
    driver.find_element(By.CSS_SELECTOR, "a.admin-card").click()
    time.sleep(1)
    assert "admin-login.html" in driver.current_url

def test_teacher_login_link_works(driver):
    """Clicking Teacher Login card goes to teacher-login.html"""
    driver.get(BASE + "/index.html")
    driver.find_element(By.CSS_SELECTOR, "a.teacher-card").click()
    time.sleep(1)
    assert "teacher-login.html" in driver.current_url

def test_student_login_link_works(driver):
    """Clicking Student Login card goes to student-login.html"""
    driver.get(BASE + "/index.html")
    driver.find_element(By.CSS_SELECTOR, "a.student-card").click()
    time.sleep(1)
    assert "student-login.html" in driver.current_url
