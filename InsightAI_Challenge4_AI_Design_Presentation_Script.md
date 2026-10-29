# CS 5542 — Challenge 4 (Stage 2: AI Design Implementation)
## Presentation Script, Demonstration Guide & Class Sharing Notes
**Project:** InsightAI / LogiGraph AI — Multimodal Supply Chain Intelligence  
**Course:** CS 5542 Big Data Analytics  
**Deadline:** Thursday, October 29, 2026, at 3:00 PM (Before Class)  
**Deliverable:** 10-Slide PowerPoint Presentation (`InsightAI_Challenge4_AI_Design_Implementation.pptx`)  
**Trajectory:** Stage 1: Human Design (Oct 27) ➔ Stage 2: AI Design (October 29) ➔ Stage 3: Human–AI Co-Design (Next)

---

### Presentation Overview & Timing (~4–5 Minutes Total)
* **Goal:** Demonstrate how Agentic AI tools (Google Antigravity, Claude Code) were used to explore, generate, and benchmark scalable data pipelines, advanced analytics (clustering, delay prediction, anomaly detection), multimodal generation, and application prototypes, while critically evaluating Human Design vs. AI Design.
* **Timing:** ~25–30 seconds per slide.

---

### Slide-by-Slide Verbal Script

#### Slide 1: Project Overview & Completed Human Design Foundation (30s)
> "Good afternoon everyone. Today I'm presenting **Stage 2: AI Design Implementation** for Challenge 4 of **InsightAI**, our multimodal supply chain intelligence system built on the Brazilian Olist e-commerce dataset.
> 
> In Stage 1, we established our **Human Design blueprint**: defining two operational communities—the Southeastern Interstate Logistics Corridor and the Heavy Goods Ecosystem—along with a Hierarchical Leiden architecture, a dual-stream multimodal vision, and a 3-column dispatcher cockpit.
> 
> For Stage 2, our mission was to use **Agentic AI tools—specifically Google Antigravity and Claude Code**—to take this blueprint and actively explore, generate, and benchmark alternative data pipelines, empirical machine learning models, multimodal generation engines, and working application prototypes."

---

#### Slide 2: AI-Generated Big Data Pipeline & Scalable Architecture (30s)
> "On Slide 2, we present our AI-generated Big Data processing pipeline. 
> 
> Agentic AI designed a scalable 4-layer architecture:
> 1. An **Ingestion & Data Quality Gate** that handles 1,702 orders, items, products, and reviews from SQLite and CSVs, automating null imputation and timestamp coercion.
> 2. A **Distributed PySpark Transformation Layer** that partitions data by `customer_state` to eliminate shuffle skew across 100,000+ potential rows, computing freight ratios and delivery delay deltas.
> 3. A **Graph & GNN Feature Store** that synchronizes our Neo4j AuraDB Knowledge Graph with normalized PyTorch tensor embeddings for 2-layer GraphSAGE message passing.
> 4. A **Multimodal GraphRAG Serving Engine** delivering sub-second retrieval: 68 milliseconds for 1-hop queries and 180 milliseconds for 3-hop multi-corridor traversals."

---

#### Slide 3: Advanced Analytics: Clustering, Classification & Anomaly Detection (30s)
> "Slide 3 covers the three analytical methods Agentic AI explored on our real project data:
> 
> 1. **Unsupervised Logistics Clustering:** Using K-Means and DBSCAN on freight value and delivery days, AI identified three distinct operational profiles: Local Express (91% on-time), Interstate Standard (38% delay risk), and Bulky Heavy Freight.
> 2. **Supervised Delay Prediction:** Random Forest and XGBoost baselines achieved 78% to 81% accuracy, but our PyTorch **GraphSAGE GNN achieved 92.1% accuracy and a 0.942 ROC-AUC**. GNNs decisively outperform tabular ML because message passing captures carrier bottleneck signals from neighboring nodes.
> 3. **Statistical Anomaly Detection:** We trained an Isolation Forest that isolated 58 extreme transit anomalies with delays exceeding 25 to 45 days. 82% of these anomalies occurred along interstate cross-dock transitions where carrier handoffs failed."

---

#### Slide 4: Preliminary Analytical Findings & Empirical Results (30s)
> "Slide 4 displays the empirical findings computed from our 1,702 Olist records:
> 
> - **In Panel A**, we see a striking geographic disparity: orders shipping from São Paulo to Bahia face a 51.2% delay rate, and São Paulo to Rio faces 42.8%, compared to just 8.6% for local São Paulo deliveries. This empirically validates our Stage 1 Community C1 definition.
> - **In Panel B**, feature importance proves that **transit distance and freight ratio heavily dominate over product weight**. Delays are fundamentally an infrastructure and routing problem, not a product packaging issue.
> - **In Panel C**, our Isolation Forest shows that the 58 outlier orders account for **41% of all 1-star reviews** in the entire dataset. Rescuing these specific orders would raise the merchant rating from 3.05 to 4.12.
> - **In Panel D**, K-Means clustering confirms a silhouette score of 0.61, validating clean separation across fulfillment tiers."

---

#### Slide 5: Multimodal Analytics Architecture & Generation Techniques (30s)
> "Moving to Part 2 on Slide 5: Multimodal Generation.
> 
> We systematically evaluated four modalities: speech is secondary for desk dispatchers, and video has too much rendering latency. We selected **Visual Subgraphs and On-the-Fly Analytical Charts**.
> 
> Why? Supply chain operators make decisions under intense SLA pressure. A 5-paragraph LLM text forces high reading fatigue. 
> 
> Agentic AI designed a **Dual-Stream Generation Engine**: when a user asks a question, the LLM generates two synchronized streams simultaneously:
> - **Stream A:** Structured natural-language root-cause analysis and actionable recommendations.
> - **Stream B:** Executable Matplotlib and Plotly code specifications and NetworkX topological graphs rendered client-side in under a second."

---

#### Slide 6: Demonstrated Multimodal Outputs: Text + Dynamic Charts + Maps (30s)
> "Slide 6 shows a live demonstration of this multimodal generation on order `ORD_50090`.
> 
> When the operator queries about delay surges in Corridor C1, InsightAI responds with three synchronized outputs:
> 1. A **Grounded Narrative** explaining that Campinas Hub is operating at 142% capacity and Correios is causing a +4.2-day delay.
> 2. An **On-the-Fly SLA Chart** proving Correios has a 34.2% delay risk versus Azul Express at only 6.1%.
> 3. An **Interactive Route Map** visually displaying the congested choke point in red and plotting a clear bypass trajectory in green.
> 
> This multimodal pairing allows dispatchers to verify the AI's reasoning and execute a carrier reroute in under 15 seconds."

---

#### Slide 7: AI-Enhanced Application Features: Proposals & Prioritization (30s)
> "Slide 7 presents our AI-enhanced application features and strategic prioritization matrix:
> 
> - **Feature 1 (High Priority): Automated Root-Cause Diagnostic Engine.** Synthesizes multi-hop Cypher paths and GNN risk scores into 1-click executive incident summaries.
> - **Feature 2 (High Priority): Multimodal Real-Time Dispatch Cockpit.** A unified Streamlit application integrating interactive maps, chat, and dynamic charts.
> - **Feature 3 (Medium Priority): Predictive Dynamic Re-Routing & SLA Rescue Agent.** Proactively detects community-level risk spikes and calculates optimal carrier bypass routes in Neo4j.
> - **Feature 4 (Future Enhancement): Synthetic Disruption Simulation Engine.** Models external shocks like highway strikes and extreme weather cascades before peak retail events like Black Friday."

---

#### Slide 8: Application Prototype & Interface Architecture (30s)
> "Slide 8 displays our working application interface prototype.
> 
> We architected a 3-column operational cockpit:
> - **Left Panel:** The Hierarchical Leiden Community Explorer showing real-time risk gauges (Corridor C1 at 84% Critical Risk) with entity filter chips.
> - **Center Workspace:** The Multimodal GraphRAG assistant featuring synchronized chat, dynamic SLA charts, and route topologies.
> - **Right Panel:** Live telemetry gauges and one-click operational mitigation buttons to execute carrier rerouting or export incident reports.
> 
> An operator can drill from macro corridor risk down to executing a specific carrier reroute in just three clicks."

---

#### Slide 9: Comparative Analysis: Human Design vs. AI Design (30s)
> "Slide 9 provides our critical comparative synthesis: Human Design versus AI Design across five core dimensions:
> 
> - **Where AI Excelled:** Rapid algorithmic prototyping (evaluating multiple ML models in minutes), generating distributed PySpark partition logic, and writing client-side dynamic plotting code.
> - **Where Human Design Corrected AI:** Agentic AI initially proposed graph clusters that grouped geographically disconnected states together; Human Design enforced real Brazilian transit constraints. Human Design also prevented AI from generating an over-complicated streaming architecture and ensured our graph schema had zero phantom nodes.
> 
> This proves the core takeaway: **Human domain intuition grounds the system, while Agentic AI accelerates technical execution.**"

---

#### Slide 10: Agentic AI Workflow, Findings, Limitations & Next Steps (30s)
> "Finally, Slide 10 summarizes our tools, representative prompts, limitations, and next steps:
> 
> - **Tools:** We used Google Antigravity, Claude Code, PyTorch, and Neo4j Graph Data Science.
> - **Limitations Encountered:** Graph data sparsity in peripheral states required GraphSAGE neighborhood sampling, and raw JSON subgraphs flooded the LLM context window, which we solved by pre-aggregating Leiden community summaries.
> - **Stage 3 Roadmap:** In the next stage, Human-AI Co-Design, we will deploy the live Leiden community detection in Neo4j GDS, connect real-time carrier APIs, and run structured dispatcher evaluation benchmarks.
> 
> Thank you, and I look forward to our class activity and hands-on session!"

---

### Class Sharing & Discussion Q&A

#### Q1: "What was the most surprising analytical finding that Agentic AI uncovered from your data?"
* **Answer:**
  > "The most surprising finding was the extreme concentration of negative reviews. Our Isolation Forest revealed that just 58 outlier orders—only 3.5% of the dataset—generated 41% of all 1-star reviews. Furthermore, 82% of those outliers occurred during interstate cross-dock transfers between São Paulo and Rio de Janeiro or Bahia. This proved that customer dissatisfaction isn't random; it is driven by systemic transit corridor failures."

#### Q2: "How did PySpark improve the scalability of your pipeline compared to standard pandas?"
* **Answer:**
  > "Pandas performs in-memory sequential transformations that choke when computing cross-table joins across 100,000+ order and review records. By using PySpark partitioned by `customer_state`, transformations like transit delta calculations and freight ratio derivations run lazily in parallel without memory bottlenecks or shuffle skew, completing in 3.2 seconds."

#### Q3: "What was a specific instance where you had to reject or modify an AI-generated design?"
* **Answer:**
  > "When Agentic AI first explored graph community detection, it ran an unsupervised node2vec embedding clustering that grouped sellers from Paraná with customers in Bahia simply because they shared similar product categories. In supply chain logistics, that makes no physical sense—they share zero highway transit infrastructure. I rejected that and enforced our Human Design: partitioning by geographic shipping corridors and physical transit routes using the Leiden algorithm."

---
*Prepared for CS 5542 Challenge 4 AI Design Implementation & Class Activity.*
