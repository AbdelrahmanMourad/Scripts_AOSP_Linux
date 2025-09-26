# 🐬 Mermaid Cheatsheet & Examples

A quick reference to learn **Mermaid diagrams** inside Markdown.

---

## 1. Flowchart Basics

```mermaid
flowchart TD
    A([Start]) --> B[Process Step]
    B --> C{Decision?}
    C -->|Yes| D[Do This]
    C -->|No| E[Do That]
    D --> F([End])
    E --> F([End])
```

### Explanation:
- `TD` → Top-to-Down layout (can also use `LR`, `BT`, `RL`).
- `()` → Rounded rectangle (terminator).
- `[]` → Rectangle (process).
- `{}` → Diamond (decision).

--- 

## 2. Arrow Types

```mermaid
flowchart LR
    A[Normal Arrow] --> B[Next]
    C[Dashed Arrow] -.-> D[Next]
    E[Thick Arrow] ==> F[Next]
```

---

## 3. Node Shapes

```mermaid
flowchart TD
    A([Rounded Rectangle])
    B([Circle]):::circle
    C{Decision Diamond}
    D[(Database)]
    E((Circle Node))
    F[/Parallelogram/]
    G[\Parallelogram\]
    H>"Asymmetric Shape"]
    I{{Hexagon}}
```

---

## 4. Coloring & Classes

```mermaid
flowchart TD
    A([Start]) --> B[Check Files]
    B --> C{Files Found?}
    C -->|Yes| D[Process Files]
    C -->|No| E[Show Error]
    D --> F([Done])
    E --> F

    %% --- Class Definitions ---
    classDef startEnd fill:#4CAF50,stroke:#2E7D32,color:#fff,font-weight:bold;
    classDef decision fill:#FFEB3B,stroke:#FBC02D,color:#000;
    classDef process fill:#64B5F6,stroke:#1E88E5,color:#fff;
    classDef error fill:#E57373,stroke:#C62828,color:#fff;

    %% --- Assign Classes ---
    class A,F startEnd;
    class B,D process;
    class C decision;
    class E error;
```

---

## 5. Subgraphs (Grouping)

```mermaid
flowchart TB
    subgraph CLIENT [Client Side]
        A[Browser] --> B[Send Request]
    end

    subgraph SERVER [Server Side]
        C[API] --> D[Database]
    end

    B --> C
```

--

## 6. Sequence Diagrams

```mermaid
sequenceDiagram
    participant User
    participant Browser
    participant Server

    User->>Browser: Clicks "Login"
    Browser->>Server: POST /login
    Server-->>Browser: 200 OK
    Browser-->>User: Welcome Page
```

---

## 7. Class Diagram (UML Style)

```mermaid
classDiagram
    class Box {
        -int length
        -int width
        -int height
        +Box()
        +volume() long long
    }

    class Container {
        -list~Box~ boxes
        +addBox(Box b)
        +totalVolume() long long
    }

    Box <|-- Container
```

---

## 8. State Diagram

```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Running : Start Engine
    Running --> Idle : Stop Engine
    Running --> Error : Fault Detected
    Error --> [*]
```

---

## 9. Gantt Chart (Timelines)

```mermaid
gantt
    title Project Timeline
    dateFormat  YYYY-MM-DD
    section Phase 1
    Setup           :done,    des1, 2025-09-01,2025-09-05
    Research        :active,  des2, 2025-09-06, 5d
    section Phase 2
    Development     :         des3, 2025-09-12, 10d
    Testing         :         des4, after des3, 7d
```

---

## 10. Pie Chart

```mermaid
pie title Disk Usage
    "System" : 20
    "Home" : 60
    "Other" : 20
```

---

## 11. Cheatsheet Table

| Shape Syntax | Shape               |
| ------------ | ------------------- |
| `[Text]`     | Rectangle (Process) |
| `(Text)`     | Rounded Rectangle   |
| `{Text}`     | Diamond (Decision)  |
| `((Text))`   | Circle              |
| `((Text))`   | Circle              |
| `[/Text/]`   | Parallelogram (I/O) |
| `[[Text]]`   | Subroutine          |
| `((Text))`   | Circle Terminator   |
| `-->`        | Normal Arrow        |
| `-.->`       | Dashed Arrow        |
| `==>`        | Thick Arrow         |


---

## ✅ Tips

- Use `classDef` to style multiple nodes consistently.
- Use `subgraph` to organize sections.
- Escape special symbols with `\` if they break syntax (`\~`, `\$USER`).
- Use quotes for multi-line labels: `["Line1<br>Line2"]`.

---


# Mermaid Diagrams Detailed Learning (One Paragraph)

- ### Mermaid is a powerful tool to create diagrams in Markdown using a simple text syntax, and it supports many diagram types such as 
    - **flowcharts**, 
    - **sequence diagrams**, 
    - **class diagrams**, 
    - **state diagrams**, 
    - **entity-relationship (ER) diagrams**, 
    - **journey diagrams**, and 
    - **Gantt charts**. 
- ### For example, 
    - in **`flowcharts`** 
        - you can define the direction (`TD` for top-down, `LR` for  left-right), 
        - nodes with different shapes like 
            - rectangles `[Process]`, 
            - circles `((Terminator))`, 
            - diamonds `{Decision}`, 
            - subroutines `[[Subroutine]]`, and 
        - links using arrows 
            - `-->` (normal arrow), 
            - `-.->` (dashed arrow), 
            - `==>` (thick arrow). 
        - You can also add **styles** with `classDef` to color nodes (`fill`, `stroke`, `color`, `font-weight`) and then apply them with `class`. 
        - For instance: 

```mermaid
flowchart TD
    A([Start]) --> B{Check Condition}
    B -->|True| C[Do Action]
    B -->|False| D[Do Something Else]
    C --> E([End])
    D --> E
    classDef startEnd fill:#4CAF50,stroke:#2E7D32,color:#fff;
    classDef decision fill:#FFEB3B,stroke:#FBC02D,color:#000;
    classDef process fill:#64B5F6,stroke:#1E88E5,color:#fff;
    class A,E startEnd;
    class B decision;
    class C,D process;
```
- This example shows different shapes and colors to make a readable workflow. 

--- 

- ### Another type is the **`sequence diagram`**, which shows interactions between participants over time, for example: 

```mermaid
sequenceDiagram
    participant User
    participant System
    User->>System: Login Request
    System-->>User: Login Response
    User->>System: Perform Action
    System-->>User: Result
```

- Here `->>` means a solid line with an arrow, 
- while `-->>` means a dashed line response. 

---

- ### For **`class diagrams`**, you can model objects like in **`UML`**: 

```mermaid
classDiagram
    class Animal {
        +String name
        +int age
        +makeSound()
    }
    class Dog {
        +String breed
        +bark()
    }
    Animal <|-- Dog
```
- This shows `Dog` inherits from `Animal`. 

---

- ### In **`state diagrams`**, you can represent transitions: 

```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Working : Start
    Working --> Idle : Stop
    Working --> Error : Fault
    Error --> Idle : Reset
```
- The `[ * ]` means the initial state. 

---

- ### You can also make **`ER diagrams`** for databases: 

```mermaid
erDiagram
    USER ||--o{ ORDER : places
    ORDER ||--|{ LINE_ITEM : contains
    PRODUCT ||--o{ LINE_ITEM : listed_in
```
- This shows relationships between tables. 

---

- ### For project planning, **`Gantt charts`** are supported: 

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title A Sample Project
    section Phase 1
    Task A           :a1, 2025-09-01, 7d
    Task B           :after a1  , 5d
    section Phase 2
    Task C           :2025-09-10, 3d
```
- which visualizes tasks and timelines. 

---

- ### Mermaid also supports **`journey diagrams`** (good for user experience flow): 
```mermaid
journey
    title User Journey
    section Start
      Visit website: 5: User
    section Process
      Browse products: 4: User
      Add to cart: 3: User
    section End
      Checkout: 2: User
```
- where numbers represent satisfaction levels. 

--- 

- ### In all these, you can enrich diagrams with **`styling and classes`**. 
    - For example, you can color:
        - decision nodes `yellow`, 
        - processes `blue`, 
        - start/end `green`, and 
        - risky actions `red` 
    - by defining **`classDef`** and assigning them. 
    
- ### Mermaid diagrams are inline code blocks fenced with triple backticks and `mermaid`, and they are rendered automatically in many Markdown environments (like `GitHub`, `GitLab`, `Obsidian`, `MkDocs`, and `VSCode extensions`). 

- ### By combining `shapes`, `arrows`, `styles`, and `diagram types`, 

- ### you can express **`workflows`**, **`system designs`**, **`database schemas`**, **`timelines`**, and **`interactions`** all in Markdown ***`without external drawing tools`***,  making documentation reproducible, version-controlled, and easy to maintain.