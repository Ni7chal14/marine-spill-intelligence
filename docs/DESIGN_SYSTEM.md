Design System
Marine Spill Intelligence System
SIH26143 | Space Technology

1. Purpose

This document defines the visual and UI design standards for the Marine Spill Intelligence System.

The goal is to ensure that the application feels like:

One unified product
Professional
Modern
Scientific
Data-driven
Easy to understand

All frontend components should follow this design system.

2. Design Philosophy

The application is a:

Marine intelligence and geospatial analysis platform.

Therefore, the interface should communicate:

OCEAN
+
SATELLITE INTELLIGENCE
+
DATA ANALYSIS
+
REAL-TIME MONITORING

The design should feel similar to a professional:

Intelligence dashboard
Satellite monitoring platform
Environmental analysis system
Geospatial command center

3. Core Design Principles

3.1 Information First

The most important information should always be immediately visible.

Example:

SPILL DETECTED

Confidence: 91%
Area: 12.4 km²
Observation: 2 hours ago

Avoid hiding important information behind unnecessary clicks.

3.2 Map-Centric Design

The map is one of the main components of the application.

Important information should be visualized geographically whenever possible.

Examples:

Spill boundary
Spill origin
Drift path
Vessel locations
Vessel trajectories

3.3 Progressive Disclosure

Do not show every detail at once.

Example:

HIGH-LEVEL RESULT
       ↓
CLICK / EXPAND
       ↓
DETAILED ANALYSIS
       ↓
FULL TECHNICAL DATA

This keeps the interface clean.

3.4 Scientific but Understandable

The platform should look technically advanced without overwhelming the user.

Avoid:

Excessive technical jargon
Overcrowded charts
Too many numbers
Complex controls

4. Visual Direction

The preferred visual direction is:

MODERN
MINIMAL
DARK
GEOSPATIAL
DATA-DRIVEN

The UI should feel like a modern intelligence platform rather than a traditional government dashboard.

5. Color System
Primary Colors

The main visual identity should be based around:

Deep Ocean
Marine Blue
Cyan / Teal

Suggested semantic roles:

PRIMARY
→ Main actions
→ Important controls

SECONDARY
→ Supporting information

ACCENT
→ Highlights
→ Active states
Semantic Colors

Colors should communicate meaning.

Success

Used for:

Analysis Completed
System Healthy
Low Risk
Warning

Used for:

Medium Confidence
Potential Look-Alike
Processing Warning
Danger

Used for:

Oil Spill Detected
High Priority
Critical Alert
Information

Used for:

Satellite Data
Observation Information
General Status
Important Rule

Do not rely only on color to communicate important information.

Always combine:

COLOR
+
ICON
+
TEXT

Example:

● HIGH PRIORITY

rather than only a red dot.

6. Typography

The typography should be:

CLEAR
MODERN
HIGHLY READABLE
Typography Hierarchy
Display

Used for:

Major page headings
Important dashboard metrics

Example:

Marine Spill Intelligence
Heading

Used for:

Section titles
Panel headings

Example:

Spill Analysis
Body

Used for:

Descriptions
General information

Example:

Satellite imagery was analysed for possible oil spill activity.
Caption

Used for:

Metadata
Timestamps
Secondary information

Example:

Last updated: 5 minutes ago

7. Spacing System

Use consistent spacing throughout the application.

Recommended conceptual scale:

XS
SM
MD
LG
XL
2XL

Example:

XS → Very small gap
SM → Small gap
MD → Standard gap
LG → Section gap
XL → Major section gap

Avoid random spacing values across different components.

8. Layout System

The application should use a responsive layout.

Desktop

The primary SIH demonstration interface will likely be desktop-first.

Example:

┌──────────────────────────────────────────────┐
│ TOP NAVIGATION                               │
├──────────────┬───────────────────────────────┤
│              │                               │
│ SIDEBAR      │          MAIN CONTENT         │
│              │                               │
│              │                               │
└──────────────┴───────────────────────────────┘
Mobile

Mobile support should remain usable, but the main focus is:

DESKTOP
↓
TABLET
↓
MOBILE

9. Application Layout

Recommended global structure:

APP
│
├── Sidebar
│
├── Top Bar
│
└── Main Content
Sidebar

The sidebar contains primary navigation.

Suggested sections:

Dashboard

Monitoring

Historical Events

Upload Analysis

Investigations

Data & Insights

The exact names can evolve.

Top Bar

The top bar may contain:

Current page title
Search
System status
Latest observation time
User controls

10. Core UI Components

All pages should reuse common components.

Buttons

Button types:

PRIMARY
SECONDARY
OUTLINE
GHOST
DANGER

Examples:

[ Start Analysis ]

[ View Details ]

[ Cancel ]
Cards

Cards are used for grouping related information.

Examples:

Spill summary
Confidence score
Vessel information
Historical event

Cards should maintain consistent:

Padding
Border radius
Shadows
Header structure
Status Badge

Used for system and analysis states.

Examples:

PROCESSING
COMPLETED
FAILED
OIL SPILL
LOOK-ALIKE
HIGH PRIORITY
Data Metric

Used for important numerical information.

Example:

12.4
km²

Estimated Spill Area
Tables

Used for:

Vessel investigations
Historical events
Analysis history

Tables should support:

Sorting
Clear column hierarchy
Status indicators
Expandable details where necessary

11. Map Component

The map is a core system component.

It should support multiple layers.

MAP
│
├── Satellite Base Layer
│
├── Spill Layer
│
├── Origin Layer
│
├── Drift Layer
│
└── Vessel Layer
Layer Controls

Users should be able to toggle important layers.

Example:

☑ Spill Boundary

☑ Origin Estimate

☑ Drift Path

☑ Vessel Trajectories

12. Map Visual Hierarchy

The map should clearly differentiate between data types.

Conceptually:

SPILL
→ Primary focus

ORIGIN REGION
→ Investigation area

DRIFT PATH
→ Movement

VESSELS
→ Investigation targets

Avoid making all map layers equally visually dominant.

13. Dashboard Design

The dashboard should answer:

What is happening right now?

Suggested structure:

SYSTEM STATUS

KEY METRICS

RECENT ANALYSES

MAP OVERVIEW

RECENT ALERTS
Example Metrics
Latest Observation

Spills Detected

Active Analyses

High-Priority Vessels

14. Monitoring Page

The monitoring page focuses on near-real-time satellite analysis.

Suggested flow:

REGION SELECTION
        ↓
START ANALYSIS
        ↓
PROCESSING STATE
        ↓
RESULT
Recommended Layout
┌────────────────────────────────────────────┐
│ REGION CONTROLS                            │
├─────────────────────────┬──────────────────┤
│                         │                  │
│                         │  ANALYSIS PANEL  │
│          MAP            │                  │
│                         │                  │
│                         │                  │
└─────────────────────────┴──────────────────┘

15. Historical Events Page

The page should allow users to explore known events.

Suggested interface:

EVENT LIST
      │
      ▼
SELECT EVENT
      │
      ▼
EVENT DETAILS
      │
      ▼
RUN / LOAD ANALYSIS

Each event card may show:

Event name
Date
Region
Short description

16. Upload Analysis Page

The upload interface should be simple.

Suggested flow:

UPLOAD FILE
     ↓
VALIDATE FILE
     ↓
DETECT METADATA
     ↓
SHOW AVAILABLE ANALYSIS
     ↓
RUN ANALYSIS
Important UI Feedback

The user should clearly know whether the file is:

✓ GEOREFERENCED

or

⚠ IMAGE ONLY
Example
GEOREFERENCED DATA DETECTED

Available:

✓ Map Visualization
✓ Area Estimation
✓ Drift Analysis
✓ AIS Investigation

17. Analysis Page

The analysis page is the main intelligence view.

Recommended structure:

ANALYSIS HEADER

SUMMARY METRICS

INTERACTIVE MAP

DETECTION DETAILS

DRIFT ANALYSIS

VESSEL INVESTIGATION

18. Analysis Header

The header should immediately communicate the result.

Example:

OIL SPILL DETECTED

Confidence: 91%

Observation:
12 minutes ago

19. Summary Metrics

Display key information first.

Example:

┌─────────────┐
│ 12.4 km²    │
│ Spill Area  │
└─────────────┘

┌─────────────┐
│ 91%         │
│ Confidence  │
└─────────────┘

┌─────────────┐
│ HIGH        │
│ Priority    │
└─────────────┘

20. Spill Visualization

The spill visualization should communicate:

WHERE
HOW LARGE
HOW CONFIDENT
WHEN OBSERVED

The map should display:

SATELLITE IMAGE
       +
SPILL BOUNDARY
       +
SPILL CENTROID

21. Drift Visualization

The drift visualization should support time-based exploration.

Example:

PAST
│
●──────────────►
│
PRESENT
│
●──────────────►
│
FUTURE

Users should be able to understand:

Where the spill may have come from
Where it may move next

22. Timeline Component

A timeline should be used for temporal exploration.

Example:

◀──────────────●──────────────▶

Past          Present          Future

Possible controls:

[ ◀ ] [ PLAY ] [ ▶ ]

The timeline can animate:

Spill movement
Drift simulation
Vessel movement

23. Vessel Investigation UI

Vessels should be presented as:

RANKED INVESTIGATION TARGETS

Example:

#1 Vessel Alpha

Priority Score: 92

Reasons:
• Present near origin region
• Present during origin window
• Relevant trajectory
Investigation Table

Suggested columns:

Rank
Vessel
Type
Priority
Evidence
Action

Example:

#1 | Vessel Alpha | Tanker | 92 | View Evidence

24. Explainability

The system should explain its results.

Avoid:

Vessel Alpha
Score: 92

Prefer:

Vessel Alpha
Priority Score: 92

Why?

✓ Near estimated origin region
✓ Present during relevant time window
✓ Trajectory intersects investigation zone

This improves:

Trust
Understandability
Presentation quality

25. Loading States

The application must show clear processing states.

Example:

ANALYSING SATELLITE DATA

████████░░░░░░░░

65%

Running drift simulation...

Avoid blank screens during processing.

26. Error States

Errors should be understandable.

Bad:

ERROR 500

Better:

Satellite Data Unavailable

No suitable satellite observation was
found for the selected region.

[ Try Another Region ]

27. Empty States

The application should handle empty results.

Example:

NO SIGNIFICANT OIL SPILL DETECTED

The selected satellite observation was
successfully analysed.

This is a valid system result.

28. Animations and Motion

Motion should be purposeful.

Good uses:

Spill drift movement
Timeline transitions
Loading progress
Map layer transitions

Avoid excessive:

Bouncing
Flashing
Unnecessary animations

29. Micro-Interactions

Small interactions can improve the product feel.

Examples:

Button hover

Map layer fade

Card expansion

Timeline movement

Progress transitions

Keep them subtle.

30. Icons

Use icons consistently.

Recommended usage:

Map → Location icon

Satellite → Satellite icon

Upload → Upload icon

Vessel → Ship icon

Analysis → Chart / Activity icon

Avoid mixing multiple unrelated icon styles.

31. Responsive Behavior

Components should adapt based on screen size.

Example:

DESKTOP

MAP + ANALYSIS PANEL


TABLET

MAP
ANALYSIS PANEL


MOBILE

STACKED CONTENT

32. Accessibility

The interface should consider:

Readable text
Clear contrast
Keyboard accessibility where possible
Text labels
Non-color indicators

Important alerts should never depend only on color.

33. UI Component Reuse

Do not create completely separate versions of common components.

Example:

Instead of:

SpillCardDashboard

SpillCardMonitoring

SpillCardHistorical

Prefer:

SpillCard

with configurable data.

34. Suggested Component Structure
components/
│
├── ui/
│   ├── Button
│   ├── Card
│   ├── Badge
│   ├── Modal
│   └── Loader
│
├── map/
│   ├── MapView
│   ├── SpillLayer
│   ├── DriftLayer
│   ├── VesselLayer
│   └── LayerControls
│
├── analysis/
│   ├── AnalysisHeader
│   ├── SpillSummary
│   ├── DetectionResult
│   └── AnalysisProgress
│
├── investigation/
│   ├── VesselTable
│   ├── VesselCard
│   └── EvidencePanel
│
└── layout/
    ├── Sidebar
    ├── Topbar
    └── PageLayout

The exact structure can evolve.

35. Page Consistency Rules

Every major page should follow:

PAGE TITLE

SHORT DESCRIPTION

PRIMARY CONTENT

SUPPORTING INFORMATION

Example:

Monitoring

Analyse the latest available satellite
observation for a selected maritime region.

[ MAP ]

[ ANALYSIS PANEL ]

36. Design Quality Checklist

Before completing a page, check:

Consistency
✓ Same spacing
✓ Same typography
✓ Same button styles
✓ Same cards
Clarity
✓ Important information visible
✓ Status clearly shown
✓ Errors understandable
Functionality
✓ Loading states
✓ Empty states
✓ Error states
Visualization
✓ Map data understandable
✓ Layers distinguishable
✓ Timeline clear

37. Final Design Direction

The final application should feel like:

A modern satellite-powered marine intelligence platform.

The user experience should follow:

OBSERVE
   ↓
DETECT
   ↓
UNDERSTAND
   ↓
TRACE
   ↓
INVESTIGATE
   ↓
PREDICT

38. Design System Summary

The visual identity should combine:

MARINE
+
SATELLITE
+
INTELLIGENCE
+
GEOSPATIAL DATA

The most important UI principles are:

MAP-CENTRIC

INFORMATION-FIRST

CONSISTENT

EXPLAINABLE

PROFESSIONAL

MODERN

Every screen should help the user quickly answer:

WHAT HAPPENED?

WHERE DID IT HAPPEN?

HOW CONFIDENT ARE WE?

WHERE DID IT COME FROM?

WHERE COULD IT GO?

WHICH VESSELS REQUIRE INVESTIGATION?