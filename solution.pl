% task(TaskID, Description, Assignee, CompletionStatus).
% CompletionStatus is false for incomplete tasks by default.

% 1. Create a new task.
create_task(TaskID, Description, Assignee) :-
    assertz(task(TaskID, Description, Assignee, false)),
    format('Task created: ~w.~n', [TaskID]).

% 2. Assign an existing task to a user.
assign_task(TaskID, NewAssignee) :-
    retract(task(TaskID, Description, _, CompletionStatus)),
    assertz(task(TaskID, Description, NewAssignee, CompletionStatus)),
    format('Task ~w assigned to user: ~w.~n', [TaskID, NewAssignee]).

% 3. Mark a task as completed.
mark_completed(TaskID) :-
    retract(task(TaskID, Description, Assignee, _)),
    assertz(task(TaskID, Description, Assignee, true)),
    format('Task ~w marked as completed.~n', [TaskID]).

% 4. Display all tasks with their details.
display_tasks :-
    forall(task(TaskID, Description, Assignee, CompletionStatus),
           (format('Task ~w:~n', [TaskID]),
            format('- Description: ~w~n', [Description]),
            format('- Assignee: ~w~n', [Assignee]),
            format('- Completion status: ~w~n', [CompletionStatus]),
            nl)).

% 5. Display tasks assigned to a specific user.
display_tasks_assigned_to(User) :-
    format('Tasks assigned to ~w:~n', [User]),
    forall((task(TaskID, Description, User, CompletionStatus)),
           (format('Task ~w:~n', [TaskID]),
            format('- Description: ~w~n', [Description]),
            format('- Completion status: ~w~n', [CompletionStatus]),
            nl)).

% 6. Display all completed tasks.
display_completed_tasks :-
    writeln('Completed tasks:'),
    forall((task(TaskID, Description, Assignee, true)),
           (format('Task ~w:~n', [TaskID]),
            format('- Description: ~w~n', [Description]),
            format('- Assignee: ~w~n', [Assignee]),
            nl)).

?- create_task(1, 'Implement login functionality', 'Alice').

?- assign_task(1, 'John').

?- mark_completed(1).

?- display_tasks.

?- display_tasks_assigned_to('Alice').


