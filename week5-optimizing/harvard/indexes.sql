create index
    idx_enrollments_student
on
    enrollments(student_id);

create index
    idx_enrollments_course
on
    enrollments(course_id);

create index
    idx_courses_department
on
    courses(department);

create index
    idx_satisfies_courseid
on
    satisfies(course_id);


create index
    idx_courses_semester
on
    courses(semester);
