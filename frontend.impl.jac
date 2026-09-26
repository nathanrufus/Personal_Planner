"""Implementations for the Personal_Planner frontend component."""

impl app.loadData -> None {
    course_result = root spawn ListCourses();
    courses = course_result.reports;

    assignment_result = root spawn ListAssignments();
    assignments = assignment_result.reports;
}

impl app.addCourse(e: FormEvent) -> None {
    e.preventDefault();
    if not course_name.strip() {
        return;
    }
    result = root spawn AddCourse(name=course_name.strip());
    courses = courses + result.reports;
    course_name = "";
}

impl app.addAssignment(e: FormEvent) -> None {
    e.preventDefault();
    if not selected_course or not title.strip() or not due_date {
        return;
    }
    result = root spawn AddAssignment(
        course_id=selected_course,
        title=title.strip(),
        due_date=due_date,
        priority=priority
    );
    assignments = assignments + result.reports;
    title = "";
    due_date = "";
}

impl app.markStatus(assignment_id: str, status: str) -> None {
    result = root spawn UpdateStatus(assignment_id=assignment_id, status=status);
    if result.reports {
        updated = result.reports[0];
        assignments = [updated if jid(t) == assignment_id else t for t in assignments];
    }
}