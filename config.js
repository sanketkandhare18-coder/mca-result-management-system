/* Supabase project credentials */
const SUPABASE_URL = "https://kcdevsnrwzcikrsasavx.supabase.co";
const SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtjZGV2c25yd3pjaWtyc2FzYXZ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzU0Njk0MTAsImV4cCI6MjA5MTA0NTQxMH0.EHMrwF53n6df9ZoWFyN3K4LY5BWL-XLfIZOI2BmrXUc";

window._db = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

/* Grade logic based on percentage */
window.calcGrade = function(pct) {
    if (pct >= 75) return 'O';
    if (pct >= 65) return 'A+';
    if (pct >= 55) return 'A';
    if (pct >= 45) return 'B+';
    if (pct >= 35) return 'B';
    return 'F';
};

/* Whether a grade is passing */
window.isPassing = function(pct) {
    return pct >= 35;
};

/* Show a timed status toast inside any element by id */
window.showMsg = function(id, text, type) {
    var el = document.getElementById(id);
    if (!el) return;
    el.textContent   = text;
    el.className     = 'message-box ' + (type || 'success') + ' show';
    el.style.display = 'block';
    clearTimeout(el._t);
    el._t = setTimeout(function() {
        el.textContent   = '';
        el.style.display = 'none';
        el.className     = 'message-box';
    }, 4500);
};

/* MCA structure constants */
window.MCACLASSES = ['FY MCA', 'SY MCA', 'TY MCA'];
window.SEMESTERS   = [1, 2];
