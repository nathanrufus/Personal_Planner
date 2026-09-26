"""Personal_Planner - Entry Point.

Combines server-side endpoints with the client-side UI.
"""

import from endpoints {
    Course, Assignment,
    AddCourse, AddAssignment, ListCourses, ListAssignments, UpdateStatus
}

# Client-side UI

import from .frontend { app as ClientApp }

def:pub app -> JsxElement {
    <ClientApp/>
}