"""Personal_Planner - Client-Side UI."""

import "./assets/main.css";

import from components.AssignmentCard { AssignmentCard }

import from endpoints {
    Course, Assignment,
    AddCourse, AddAssignment, ListCourses, ListAssignments, UpdateStatus
}

def:pub app -> JsxElement {
    has courses: list[Course] = [],
        assignments: list[Assignment] = [],
        course_name: str = "",
        selected_course: str = "",
        title: str = "",
        due_date: str = "",
        priority: str = "medium";

    can with entry {
        loadData();
    }

    async def loadData -> None;
    async def addCourse(e: FormEvent) -> None;
    async def addAssignment(e: FormEvent) -> None;
    async def markStatus(assignment_id: str, status: str) -> None;

    <div className="max-w-2xl mx-auto px-4 py-8 font-sans text-slate-900">
        <h1 className="text-2xl font-bold mb-1">Coursework Tracker</h1>
        <p className="text-slate-500 mb-6">Courses and assignment deadlines.</p>

        <form onSubmit={addCourse} className="flex gap-2 mb-6">
            <input
                type="text"
                value={course_name}
                onChange={lambda (e: ChangeEvent) { course_name = e.target.value; }}
                placeholder="New course name"
                className="flex-1 px-3 py-2 border border-slate-300 rounded-md"
            />
            <button type="submit" className="px-4 py-2 bg-slate-800 text-white rounded-md">
                Add Course
            </button>
        </form>

        <form onSubmit={addAssignment} className="flex flex-wrap gap-2 mb-8">
            <select
                value={selected_course}
                onChange={lambda (e: ChangeEvent) { selected_course = e.target.value; }}
                className="px-3 py-2 border border-slate-300 rounded-md"
            >
                <option value="">Select course</option>
                {[
                    <option key={jid(c)} value={jid(c)}>{c.name}</option>
                    for c in courses
                ]}
            </select>
            <input
                type="text"
                value={title}
                onChange={lambda (e: ChangeEvent) { title = e.target.value; }}
                placeholder="Assignment title"
                className="flex-1 px-3 py-2 border border-slate-300 rounded-md"
            />
            <input
                type="date"
                value={due_date}
                onChange={lambda (e: ChangeEvent) { due_date = e.target.value; }}
                className="px-3 py-2 border border-slate-300 rounded-md"
            />
            <select
                value={priority}
                onChange={lambda (e: ChangeEvent) { priority = e.target.value; }}
                className="px-3 py-2 border border-slate-300 rounded-md"
            >
                <option value="low">Low</option>
                <option value="medium">Medium</option>
                <option value="high">High</option>
            </select>
            <button type="submit" className="px-4 py-2 bg-emerald-600 text-white rounded-md">
                Add Assignment
            </button>
        </form>

        <div className="space-y-2">
            {[
                <AssignmentCard
                    key={jid(a)}
                    assignment={a}
                    onStatusChange={lambda (status: str) { markStatus(jid(a), status); }}
                /> for a in assignments
            ]}
        </div>
    </div>
}