"""Personal_Planner - Server-Side Data Layer.

Courses and Assignments are stored as nodes on the graph and persist across
restarts. Assignments hang off their Course via a plain edge.
"""

node Course {
    has name: str,
        code: str = "";
}

node Assignment {
    has title: str,
        due_date: str,
        priority: str = "medium",
        status: str = "not_started";
}

walker:pub AddCourse {
    """Create a course under root."""
    has name: str,
        code: str = "",
        reports: list[Course] = [];

    can create with Root entry {
        report here ++> Course(name=self.name, code=self.code);
    }
}

walker:pub AddAssignment {
    """Attach a new assignment to an existing course."""
    has course_id: str,
        title: str,
        due_date: str,
        priority: str = "medium",
        reports: list[Assignment] = [];

    can find_course with Root entry {
        visit [-->][?:Course];
    }

    can attach with Course entry {
        if jid(here) == self.course_id {
            report here ++> Assignment(
                title=self.title, due_date=self.due_date, priority=self.priority
            );
        }
    }
}

walker:pub ListAssignments {
    """Report every assignment across every course."""
    has reports: list[Assignment] = [];

    can collect with Root entry {
        visit [-->][?:Course];
    }

    can from_course with Course entry {
        visit [-->][?:Assignment];
    }

    can gather with Assignment entry {
        report here;
    }
}

walker:pub UpdateStatus {
    """Mark an assignment's status (not_started / in_progress / done)."""
    has assignment_id: str,
        status: str,
        reports: list[Assignment] = [];

    can find with Root entry {
        visit [-->][?:Course];
    }

    can search_course with Course entry {
        visit [-->][?:Assignment];
    }

    can update with Assignment entry {
        if jid(here) == self.assignment_id {
            here.status = self.status;
            report here;
        }
    }
}