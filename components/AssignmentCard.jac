"""A single assignment card with status controls."""

import from endpoints { Assignment }

def:pub AssignmentCard(assignment: Assignment, onStatusChange: any) -> JsxElement {
    <div className="flex items-center justify-between p-3 border border-slate-200 rounded-lg bg-white">
        <div>
            <p className="font-medium">{assignment.title}</p>
            <p className="text-sm text-slate-500">
                Due {assignment.due_date} · {assignment.priority} priority
            </p>
        </div>
        <select
            value={assignment.status}
            onChange={lambda (e: ChangeEvent) { onStatusChange(e.target.value); }}
            className="px-2 py-1 border border-slate-300 rounded-md text-sm"
        >
            <option value="not_started">Not started</option>
            <option value="in_progress">In progress</option>
            <option value="done">Done</option>
        </select>
    </div>
}