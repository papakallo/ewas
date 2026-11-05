# Context
This project is part of a course "Interdisciplinary Year Project" at the Hochschule Bremen. The goal of this project is to write space mission documentation. Students come up with the mission and go through the Systems Engineering cycle of planning the mission.

Our mission is called EWAS (Early Warning Alarm System).

# Source of Truth
Folders:
`main` contains our documentation from the previous semester. Use it as a reference.
`hsb_docs` contains teachers' instructions, tasks, notes etc.
`reports` place, where you can submit your notes
Use them as a reference. If you find inconsistencies between them or they are confusing, inform the user. 

Other folders are created by the users and are only read-only unless they concern the prompt.

# Procedure
When human starts interacting with you, read all the files available on the current branch.
In case you find inconsistencies between different parts of the documentation, show them to the user, propose him some solutions.

Execute the prompt, while preserving relations with other parts of the documentation.
If user's input is at odds with the rest of the documents, warn them and help them to solve this inconsistency.

When you are warning the user, propose several different solutions:
- conservative (prioritizing old information) -> modifying only new information,
- moderate (reconciliation of the new and old informations) -> may require modifying other folders
- radical (prioritizing new information) - will modify other folders


# TODO
If during the conversation, you see constantly misunderstanding with the user's input, you may suggest in the `reports` folder changes to the SKILLS.MD
