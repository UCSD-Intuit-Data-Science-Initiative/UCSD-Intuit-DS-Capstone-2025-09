---
layout: default
title: Home
nav_order: 1
---

# UCSD Data Science Capstone

> A central dashboard serving as the first point of entry for all users.

## Project Mission
A one-sentence summary of the project's core goal. Refine this line to match your cohort's mission.

## Latest Announcements
{% assign latest = site.data.announcements | slice: 0, 3 %}
{% if latest and latest.size > 0 %}
- {% for a in latest %}**{{ a.title }}** ({{ a.date }}): {{ a.message }}{% if forloop.last == false %}<br/>{% endif %}{% endfor %}
{% else %}
- No announcements yet.
{% endif %}

## Upcoming Deadlines
{% assign upcoming = site.data.deadlines | slice: 0, 3 %}
{% if upcoming and upcoming.size > 0 %}
- {% for d in upcoming %}**{{ d.name }}** — {{ d.date }}: {{ d.description }}{% if forloop.last == false %}<br/>{% endif %}{% endfor %}
{% else %}
- No deadlines posted.
{% endif %}

## Quick Links
- [Project Overview](project-overview)
- [View Datasets & Tech Stack](resources/)
- [See Project Timeline](timeline)
- [Book Office Hours](people-and-communication#office-hours)

---

Need something else? Use the search box above.
