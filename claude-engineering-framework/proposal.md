# Proposal:

## A Reproducible Agentic Workflow Framework for Software Engineering with Traceable Organizational Knowledge

---

# 1. Motivation

Modern software development increasingly involves complex workflows that integrate multiple sources of information, tools, and collaboration processes. Developers are expected to navigate large codebases, evolving architectural constraints, external frameworks, and institutional knowledge accumulated across previous projects. At the same time, the emergence of large language models (LLMs) and agentic development tools has begun to transform how engineers interact with software artifacts.

Recent tools such as AI code assistants, conversational agents, and autonomous software agents have demonstrated promising capabilities in code generation, documentation, and debugging. However, most of these systems focus primarily on **task-level productivity** rather than **workflow-level reproducibility** and **organizational knowledge accumulation**. In practice, software development involves long-running processes such as requirement clarification, research, design, implementation, testing, and retrospective analysis. These stages require structured coordination and traceable knowledge exchange between human engineers and automated agents.

Despite rapid advances in AI-assisted development, a persistent problem remains: **software engineering workflows are difficult to reproduce, difficult to transfer to new team members, and poorly documented in terms of experiential knowledge**. Important design decisions, debugging insights, and architectural trade-offs often remain implicit within individual developers’ experience or scattered across communication channels such as chat logs, issue trackers, and commit histories.

As development teams grow and projects evolve, this fragmentation leads to three critical challenges:

1. **Limited transferability**: New contributors face significant onboarding difficulties due to missing context and undocumented decisions.
2. **Low reproducibility**: Engineering processes cannot easily be reconstructed when similar problems arise in new projects.
3. **Weak organizational memory**: Valuable experiential knowledge accumulated during development is rarely formalized or reused.

These challenges motivate the need for a framework that integrates agentic automation with structured workflow representation and knowledge preservation.

---

# 2. Existing Solutions and Systems

Several categories of systems have attempted to address parts of this problem.

### AI Code Assistants

Systems such as GitHub Copilot, CodeWhisperer, and Claude Code assist developers in generating code snippets and explanations. These tools operate primarily at the **code editing level** and rely heavily on immediate context within the development environment. While they improve short-term productivity, they do not explicitly structure the engineering workflow or preserve the reasoning process behind design decisions.

### Autonomous Agent Frameworks

Recent agent-based frameworks such as AutoGPT, LangChain agents, and multi-agent orchestration systems attempt to automate complex tasks through prompt chaining and tool use. These frameworks typically represent workflows as sequences of prompts or task graphs executed by LLM agents. Although they enable automation of multi-step processes, they often lack mechanisms for:

- persistent workflow representation
- structured knowledge capture
- reproducible execution across projects

Furthermore, the outputs of such systems frequently depend on transient conversational context rather than well-defined artifacts.

### Software Engineering Knowledge Management Systems

Traditional knowledge management approaches in software engineering include documentation repositories, wikis, issue trackers, and architectural decision records. While these systems provide persistent documentation, they are largely **manual and retrospective**, requiring engineers to explicitly write and maintain documentation outside of the development workflow. As a result, many organizations struggle to maintain up-to-date documentation that accurately reflects real development processes.

### Gap Analysis

Across these approaches, a fundamental gap remains: **the lack of an integrated framework that connects agentic automation with reproducible engineering workflows and structured knowledge capture**.

Existing tools either automate tasks without preserving knowledge, or store documentation without integrating it into active development workflows.

---

# 3. Proposed Solution

To address these limitations, we propose a **reproducible agentic workflow framework for software engineering** that integrates:

- structured workflow orchestration
- modular agent execution
- persistent project knowledge repositories

The framework is designed around three core principles.

### Reproducibility

Engineering workflows should be represented as explicit, structured sequences of steps that can be executed, reviewed, and reproduced. Each workflow step contains a clearly defined objective, required context, execution configuration, and output contract. By formalizing development processes as structured workflow components, projects can reproduce similar development sequences in future tasks or new projects.

### Transferability

The framework enables easier onboarding of new contributors by exposing the workflow structure and associated knowledge artifacts. Instead of relying on informal communication or scattered documentation, developers can observe and replay the workflow that led to previous design decisions. This reduces onboarding time and improves collaboration across distributed teams.

### Traceable Organizational Knowledge

A key innovation of the framework is the integration of **retrospective knowledge extraction** into the workflow lifecycle. After project execution, the system aggregates artifacts, logs, and design outputs into structured knowledge elements such as:

- reusable engineering skills
- project templates
- design guidelines
- documented risks and lessons learned

These elements are stored in a shared repository that serves as the organization's evolving engineering memory.

---

# 4. Workflow-Oriented Perspective

Although the framework is implemented using technical components such as agent orchestration and structured prompts, the core challenge it addresses is not purely technical but **workflow-oriented**.

Traditional development workflows often treat retrospective knowledge capture as an optional or informal activity. In our proposed framework, retrospective knowledge extraction becomes a **first-class stage in the development lifecycle**.

During the retrospective phase, designated contributors review project artifacts and extract reusable knowledge elements, including:

- new engineering skills
- updated prompt templates
- improved project structures
- lessons learned from implementation and debugging

These elements are then integrated into the shared knowledge repository, enabling future projects to start with richer contextual resources.

By embedding knowledge capture directly into the workflow, the framework transforms retrospective analysis from a documentation exercise into a **systematic mechanism for evolving organizational expertise**.

---

# 5. Benefits and Remaining Questions

The proposed framework offers several potential benefits.

### Improved Onboarding

New contributors can understand project workflows and decision histories more effectively through structured artifacts and workflow representations.

### Reusable Engineering Processes

Organizations can reuse successful workflows across projects, reducing the need to rediscover similar engineering solutions repeatedly.

### Continuous Organizational Learning

The integration of retrospective knowledge extraction allows teams to accumulate and refine engineering practices over time.

However, several important questions remain open.

- How can knowledge extraction during retrospectives be standardized to ensure consistent quality?
- What evaluation metrics best capture improvements in workflow reproducibility and onboarding efficiency?
- How can organizations balance automation with human oversight in agent-driven workflows?

These questions motivate further research and experimentation with the framework.

---

# 6. Conclusion

This proposal introduces a framework for integrating agentic automation with reproducible software engineering workflows and traceable organizational knowledge. By formalizing development processes as structured workflow components and embedding retrospective knowledge extraction into the lifecycle, the framework aims to address persistent challenges in onboarding, workflow reproducibility, and knowledge preservation.

The proposed approach shifts the focus of AI-assisted development from isolated task automation to **workflow-level augmentation**, enabling teams to systematically accumulate and reuse engineering expertise. Future work will focus on evaluating the framework in real-world development environments and exploring methods for scaling organizational knowledge repositories across teams and projects.

---

# References (IEEE Style)

[1] T. B. Brown et al., “Language Models are Few-Shot Learners,” _Advances in Neural Information Processing Systems_, vol. 33, 2020.

[2] A. B. Vaswani et al., “Attention Is All You Need,” _Proceedings of the 31st International Conference on Neural Information Processing Systems_, 2017.

[3] S. Ouyang et al., “Training Language Models to Follow Instructions with Human Feedback,” _arXiv preprint arXiv:2203.02155_, 2022.

[4] J. Yang et al., “AutoGPT: Autonomous AI Agents,” _Open-source project_, 2023.

[5] H. H. Kagermann, “Knowledge Management in Software Engineering,” _IEEE Software_, vol. 17, no. 5, pp. 28–36, 2000.

[6] T. Fritz and G. Murphy, “Using Information Fragments to Answer the Questions Developers Ask,” _ICSE_, 2010.

[7] N. Shinnar et al., “Software Engineering Knowledge Repositories,” _IEEE Transactions on Software Engineering_, 2018.

[8] D. Storey et al., “The Future of AI-Augmented Software Development,” _IEEE Software_, vol. 38, no. 1, pp. 16–20, 2021.

---

# Phụ lục

## 1. Software Workflow (Agentic Execution Pipeline)

Đây là **workflow nội bộ của hệ thống** khi chạy một task development.

Ý tưởng chính:
workflow được **phân thành các Step Components**, mỗi step là một **bounded agent session**.

```
User Input
    │
    ▼
Project Specification
    │
    ▼
Planning Engine
(Claude agent generates workflow DAG)
    │
    ▼
Workflow Graph
 ┌─────────────────────────────────────────┐
 │ Step 1: Research                        │
 │ Step 2: Code Analysis                   │
 │ Step 3: Requirement Clarification       │
 │ Step 4: Summary                         │
 │ Step 5: Design                          │
 │ Step 6: Testcase Generation             │
 │ Step 7: Implementation                  │
 │ Step 8: Code Review                     │
 │ Step 9: Testing                         │
 │ Step 10: Retrospective                  │
 └─────────────────────────────────────────┘
    │
    ▼
Step Execution Engine
(each step runs in a new agent session)
    │
    ▼
Agent Execution
(load context + resources + prompt template)
    │
    ▼
Artifacts Generated
 ├ design docs
 ├ code patches
 ├ test cases
 └ reports
    │
    ▼
Human Review Gate
(approve / request change)
    │
    ▼
Handoff Summary
(structured context passed to next step)
    │
    ▼
Next Step
```

Điểm quan trọng của workflow này:

- **bounded context per step**
- **structured artifact outputs**
- **human review checkpoints**
- **handoff summaries instead of full chat history**

Đây là **phần technical novelty** của framework.

---

## 2. User Journey (Developer Experience)

Đây là workflow **từ góc nhìn developer sử dụng hệ thống**.

```
Developer opens dashboard
        │
        ▼
Workspace Detection
(system scans local directory)
        │
        ▼
Detected Resources
 ├ skills
 ├ docs
 ├ templates
 ├ memory
 └ workflows
        │
        ▼
User submits requirement
(example: "Implement batch job for order reconciliation")
        │
        ▼
Agent generates workflow plan
        │
        ▼
Interactive Workflow Editor
(N8N-style visual workflow)
        │
        ├─ user drags skills into steps
        ├─ user attaches docs/templates
        └─ user configures approval rules
        │
        ▼
User confirms workflow
        │
        ▼
Execution begins
        │
        ▼
Agent executes Step 1
        │
        ▼
Dashboard notification
"Research completed – review output"
        │
        ▼
User reviews artifact
        │
        ├ approve → continue
        └ request changes → agent refines output
        │
        ▼
Workflow continues
        │
        ▼
Final outputs generated
 ├ design document
 ├ test plan
 ├ code implementation
 └ review report
        │
        ▼
Retrospective phase begins
```

Điểm khác biệt so với AI code assistants:

- user **không chỉ chat với agent**
- user **orchestrates workflows**

Agent trở thành **execution engine**, không phải chỉ là chatbot.

---

## 3. Team Workflow (Organizational Knowledge Loop)

Đây là workflow **ở cấp độ team**, để đảm bảo knowledge không bị mất.

```
Project Execution
        │
        ▼
Artifacts Generated
 ├ design docs
 ├ architecture notes
 ├ code review reports
 ├ incident reports
 └ retrospective notes
        │
        ▼
Retrospective Phase
(Project team reviews outputs)
        │
        ▼
Knowledge Extraction
 ├ reusable engineering patterns
 ├ debugging strategies
 ├ new skills
 ├ improved prompts
 └ updated templates
        │
        ▼
Knowledge Repository Update
(shared repository)
 ├ skills/
 ├ docs/
 ├ templates/
 ├ workflows/
 └ memory/
        │
        ▼
Pull Request Created
(feature/project-retro branch)
        │
        ▼
Review by PIC / Tech Lead
        │
        ▼
Merged into Knowledge Main Branch
        │
        ▼
Team Sync
(all developers pull latest knowledge repo)
        │
        ▼
Next Project Starts
with improved skills/templates
```

Đây chính là **organizational learning loop**.

```
Project
   ↓
Artifacts
   ↓
Retrospective
   ↓
Knowledge Extraction
   ↓
Repository Update
   ↓
Future Projects
```

---

## 4. Tổng hợp 3 workflow

Framework của bạn thực chất có **3 tầng hoạt động**:

```
Layer 1 — Software Execution

Agent Workflow
(step-based execution)


Layer 2 — Developer Interaction

Interactive orchestration UI
(planning + review)


Layer 3 — Organizational Knowledge

Retrospective knowledge loop
```

Visual hóa:

```
              ┌────────────────────┐
              │ Organizational     │
              │ Knowledge Loop     │
              └─────────▲──────────┘
                        │
              ┌─────────┴──────────┐
              │ Developer Journey  │
              │ (Dashboard UI)     │
              └─────────▲──────────┘
                        │
              ┌─────────┴──────────┐
              │ Agent Workflow     │
              │ Execution Engine   │
              └────────────────────┘
```

---

## 5. Đây là phần quan trọng nhất cho paper

3 workflow này tương ứng với **3 contribution claims**:

| Layer             | Contribution                          |
| ----------------- | ------------------------------------- |
| Software Workflow | structured agent step execution       |
| User Journey      | workflow-oriented AI development      |
| Team Workflow     | organizational knowledge accumulation |

---
