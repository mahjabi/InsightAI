// ==============================================================================
// CS 5542 Challenge 3: InsightAI Knowledge Graph Construction Script
// Platform: Neo4j AuraDB / Neo4j Desktop
// Domain: E-Commerce Multi-Hop Logistics & Customer Review Intelligence
// Extended for GraphRAG: Enriched Semantic Entities, Attributes & Zero-Phantom Structure
// ==============================================================================

// ------------------------------------------------------------------------------
// Step 1: Schema Constraints & Indexes (Ensures Entity Uniqueness & Rapid Traversal)
// ------------------------------------------------------------------------------
CREATE CONSTRAINT IF NOT EXISTS FOR (c:Customer) REQUIRE c.customer_id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (s:Seller) REQUIRE s.seller_id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (o:Order) REQUIRE o.order_id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (p:Product) REQUIRE p.product_id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (r:Review) REQUIRE r.review_id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (route:LogisticsRoute) REQUIRE route.route_id IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (cause:ComplaintCause) REQUIRE cause.name IS UNIQUE;
CREATE CONSTRAINT IF NOT EXISTS FOR (act:RemediationAction) REQUIRE act.action_type IS UNIQUE;

// ------------------------------------------------------------------------------
// Step 2: Clear Existing Graph (Uncomment if refreshing database)
// ------------------------------------------------------------------------------
// MATCH (n) DETACH DELETE n;

// ------------------------------------------------------------------------------
// Step 3: Create Geographic Logistics Routes (Enriched with Carrier SLA & Risk)
// ------------------------------------------------------------------------------
MERGE (r1:LogisticsRoute {
    route_id: 'SP_TO_RJ',
    origin_state: 'SP',
    destination_state: 'RJ',
    avg_transit_days: 22.4,
    carrier_sla_days: 14,
    congestion_tier: 'HIGH',
    distance_km: 435,
    primary_carrier: 'Correios_Sedex'
});
MERGE (r2:LogisticsRoute {
    route_id: 'SP_TO_BA',
    origin_state: 'SP',
    destination_state: 'BA',
    avg_transit_days: 28.5,
    carrier_sla_days: 16,
    congestion_tier: 'CRITICAL',
    distance_km: 1960,
    primary_carrier: 'Jadlog_Heavy'
});
MERGE (r3:LogisticsRoute {
    route_id: 'SP_TO_MG',
    origin_state: 'SP',
    destination_state: 'MG',
    avg_transit_days: 12.1,
    carrier_sla_days: 14,
    congestion_tier: 'MODERATE',
    distance_km: 585,
    primary_carrier: 'Total_Express'
});
MERGE (r4:LogisticsRoute {
    route_id: 'PR_TO_SP',
    origin_state: 'PR',
    destination_state: 'SP',
    avg_transit_days: 8.4,
    carrier_sla_days: 12,
    congestion_tier: 'LOW',
    distance_km: 408,
    primary_carrier: 'Loggi_Priority'
});

// ------------------------------------------------------------------------------
// Step 4: Create Root-Cause Complaint Nodes & Operational Remediation Actions
// ------------------------------------------------------------------------------
MERGE (cause1:ComplaintCause {
    name: 'damaged_product',
    category: 'Physical Quality',
    severity: 'HIGH',
    impacted_metrics: 'Return Rate, CSAT, Warranty Loss',
    description: 'Physical breakage, cracked surfaces, or structural failure sustained during transit'
});
MERGE (cause2:ComplaintCause {
    name: 'delivery_delay',
    category: 'Logistics SLA',
    severity: 'HIGH',
    impacted_metrics: 'On-Time Delivery Rate, NPS, Churn',
    description: 'Actual delivery exceeded promised SLA delivery window by 5 or more calendar days'
});
MERGE (cause3:ComplaintCause {
    name: 'missing_parts',
    category: 'Packaging/Fulfillment',
    severity: 'MEDIUM',
    impacted_metrics: 'Ticket Resolution Time, Customer Dissatisfaction',
    description: 'Hardware, screws, or accessory sub-assemblies absent from shipped parcel'
});
MERGE (cause4:ComplaintCause {
    name: 'poor_quality',
    category: 'Product Spec',
    severity: 'MEDIUM',
    impacted_metrics: 'Product Return Rate, Review Score',
    description: 'Material defects, substandard stitching, or performance variance vs listing description'
});
MERGE (cause5:ComplaintCause {
    name: 'wrong_item',
    category: 'Fulfillment Error',
    severity: 'HIGH',
    impacted_metrics: 'Reverse Logistics Cost, Brand Trust',
    description: 'Warehouse barcode mix-up or incorrect SKU dispatched to buyer'
});

MERGE (act1:RemediationAction {
    action_type: 'Mandate_Reinforced_Packaging_Heavy_Items',
    target_dept: 'Logistics/Seller Ops',
    status: 'Active',
    estimated_cost_usd: 4.50,
    sla_days: 7,
    implementation_lead: 'Packaging Engineering'
});
MERGE (act2:RemediationAction {
    action_type: 'Carrier_Contract_Renegotiation_SLA',
    target_dept: 'Carrier Procurement',
    status: 'Active',
    estimated_cost_usd: 0.00,
    sla_days: 30,
    implementation_lead: 'Supply Chain Director'
});
MERGE (act3:RemediationAction {
    action_type: 'Buffer_Estimated_Delivery_Days_Plus_5',
    target_dept: 'Checkout Experience',
    status: 'Active',
    estimated_cost_usd: 0.00,
    sla_days: 3,
    implementation_lead: 'Product Manager Checkout'
});
MERGE (act4:RemediationAction {
    action_type: 'Seller_Quality_Audit_Inspection',
    target_dept: 'Merchant Compliance',
    status: 'Active',
    estimated_cost_usd: 120.00,
    sla_days: 14,
    implementation_lead: 'Vendor Operations Lead'
});

// Explicit Key-Matched Remediation Links (Zero Phantom Nodes)
MATCH (c1:ComplaintCause {name: 'damaged_product'}), (a1:RemediationAction {action_type: 'Mandate_Reinforced_Packaging_Heavy_Items'})
MERGE (c1)-[:TRIGGERS_REMEDY]->(a1);

MATCH (c2:ComplaintCause {name: 'delivery_delay'}), (a2:RemediationAction {action_type: 'Carrier_Contract_Renegotiation_SLA'})
MERGE (c2)-[:TRIGGERS_REMEDY]->(a2);

MATCH (c2:ComplaintCause {name: 'delivery_delay'}), (a3:RemediationAction {action_type: 'Buffer_Estimated_Delivery_Days_Plus_5'})
MERGE (c2)-[:TRIGGERS_REMEDY]->(a3);

MATCH (c3:ComplaintCause {name: 'missing_parts'}), (a4:RemediationAction {action_type: 'Seller_Quality_Audit_Inspection'})
MERGE (c3)-[:TRIGGERS_REMEDY]->(a4);

// ------------------------------------------------------------------------------
// Step 5: Create Product Entities (Extended Semantic Specs)
// ------------------------------------------------------------------------------
MERGE (p1:Product {
    product_id: 'PROD_1001',
    category: 'furniture_decor',
    name: 'Modern Ergonomic Coffee Table',
    weight_g: 4800,
    length_cm: 90,
    height_cm: 75,
    width_cm: 60,
    is_fragile: true,
    risk_profile: 'High Damage Risk in Transit'
});
MERGE (p2:Product {
    product_id: 'PROD_1002',
    category: 'furniture_decor',
    name: 'Solid Hardwood 3-Seater Sofa',
    weight_g: 12500,
    length_cm: 120,
    height_cm: 80,
    width_cm: 70,
    is_fragile: true,
    risk_profile: 'Heavy Freight / Fragile Structural Joints'
});
MERGE (p3:Product {
    product_id: 'PROD_1003',
    category: 'bed_bath_table',
    name: 'Egyptian Cotton Luxury Sheet Set',
    weight_g: 1100,
    length_cm: 35,
    height_cm: 15,
    width_cm: 25,
    is_fragile: false,
    risk_profile: 'Low Fragility / Material Quality Vulnerable'
});
MERGE (p4:Product {
    product_id: 'PROD_1004',
    category: 'computers_accessories',
    name: 'Mechanical RGB Gaming Keyboard',
    weight_g: 650,
    length_cm: 20,
    height_cm: 5,
    width_cm: 15,
    is_fragile: false,
    risk_profile: 'High Margin / Low Transit Incident'
});
MERGE (p5:Product {
    product_id: 'PROD_1005',
    category: 'health_beauty',
    name: 'Organic Face Moisturizer Hydration Kit',
    weight_g: 350,
    length_cm: 18,
    height_cm: 10,
    width_cm: 10,
    is_fragile: false,
    risk_profile: 'Standard Parcel / Fast Turnaround'
});
MERGE (p6:Product {
    product_id: 'PROD_1006',
    category: 'sports_leisure',
    name: 'Adjustable Dumbbell Pair 20kg',
    weight_g: 2200,
    length_cm: 50,
    height_cm: 25,
    width_cm: 30,
    is_fragile: false,
    risk_profile: 'Dense Heavy Freight'
});

// ------------------------------------------------------------------------------
// Step 6: Create Sellers & Fulfillment Hubs
// ------------------------------------------------------------------------------
MERGE (s1:Seller {
    seller_id: 'SELLER_182',
    city: 'Sao Paulo',
    state: 'SP',
    compliance_rating: 3.2,
    total_fulfilled_orders: 450,
    tier: 'Standard Marketplace'
});
MERGE (s2:Seller {
    seller_id: 'SELLER_205',
    city: 'Curitiba',
    state: 'PR',
    compliance_rating: 4.8,
    total_fulfilled_orders: 820,
    tier: 'Top Platinum Partner'
});
MERGE (s3:Seller {
    seller_id: 'SELLER_114',
    city: 'Campinas',
    state: 'SP',
    compliance_rating: 3.9,
    total_fulfilled_orders: 310,
    tier: 'Regional Verified'
});

MATCH (s1:Seller {seller_id: 'SELLER_182'}), (p1:Product {product_id: 'PROD_1001'}) MERGE (s1)-[:FULFILLS_PRODUCT]->(p1);
MATCH (s1:Seller {seller_id: 'SELLER_182'}), (p2:Product {product_id: 'PROD_1002'}) MERGE (s1)-[:FULFILLS_PRODUCT]->(p2);
MATCH (s2:Seller {seller_id: 'SELLER_205'}), (p4:Product {product_id: 'PROD_1004'}) MERGE (s2)-[:FULFILLS_PRODUCT]->(p4);
MATCH (s3:Seller {seller_id: 'SELLER_114'}), (p3:Product {product_id: 'PROD_1003'}) MERGE (s3)-[:FULFILLS_PRODUCT]->(p3);
MATCH (s3:Seller {seller_id: 'SELLER_114'}), (p5:Product {product_id: 'PROD_1005'}) MERGE (s3)-[:FULFILLS_PRODUCT]->(p5);

// ------------------------------------------------------------------------------
// Step 7: Create Customers
// ------------------------------------------------------------------------------
MERGE (c1:Customer {customer_id: 'CUST_4821', city: 'Rio de Janeiro', state: 'RJ', lifetime_orders: 2, segment: 'Frequent Buyer'});
MERGE (c2:Customer {customer_id: 'CUST_5190', city: 'Salvador', state: 'BA', lifetime_orders: 1, segment: 'First Time Buyer'});
MERGE (c3:Customer {customer_id: 'CUST_3304', city: 'Belo Horizonte', state: 'MG', lifetime_orders: 4, segment: 'VIP Retained'});
MERGE (c4:Customer {customer_id: 'CUST_1088', city: 'Sao Paulo', state: 'SP', lifetime_orders: 6, segment: 'VIP Prime'});
MERGE (c5:Customer {customer_id: 'CUST_7721', city: 'Niteroi', state: 'RJ', lifetime_orders: 1, segment: 'New Account'});

// ------------------------------------------------------------------------------
// Step 8: Create Orders & Transactional Multi-Hop Relationships
// ------------------------------------------------------------------------------
MERGE (o1:Order {
    order_id: 'ORD_50042',
    purchase_date: '2017-08-10',
    delivered_date: '2017-09-04',
    actual_delivery_days: 25,
    estimated_days: 14,
    delay_days: 11,
    is_delayed: 1,
    freight_value: 48.50,
    price: 189.90,
    status: 'delivered'
});
MATCH (c1:Customer {customer_id: 'CUST_4821'}), (o1:Order {order_id: 'ORD_50042'}), (p1:Product {product_id: 'PROD_1001'}), (s1:Seller {seller_id: 'SELLER_182'}), (r1:LogisticsRoute {route_id: 'SP_TO_RJ'})
MERGE (c1)-[:PLACED_ORDER]->(o1)
MERGE (o1)-[:CONTAINS_ITEM {quantity: 1, unit_price: 189.90}]->(p1)
MERGE (o1)-[:FULFILLED_BY]->(s1)
MERGE (o1)-[:TRANSPORTED_VIA]->(r1);

MERGE (o2:Order {
    order_id: 'ORD_50090',
    purchase_date: '2017-09-01',
    delivered_date: '2017-10-02',
    actual_delivery_days: 31,
    estimated_days: 16,
    delay_days: 15,
    is_delayed: 1,
    freight_value: 82.10,
    price: 499.00,
    status: 'delivered'
});
MATCH (c2:Customer {customer_id: 'CUST_5190'}), (o2:Order {order_id: 'ORD_50090'}), (p2:Product {product_id: 'PROD_1002'}), (s1:Seller {seller_id: 'SELLER_182'}), (r2:LogisticsRoute {route_id: 'SP_TO_BA'})
MERGE (c2)-[:PLACED_ORDER]->(o2)
MERGE (o2)-[:CONTAINS_ITEM {quantity: 1, unit_price: 499.00}]->(p2)
MERGE (o2)-[:FULFILLED_BY]->(s1)
MERGE (o2)-[:TRANSPORTED_VIA]->(r2);

MERGE (o3:Order {
    order_id: 'ORD_50119',
    purchase_date: '2017-10-12',
    delivered_date: '2017-10-31',
    actual_delivery_days: 19,
    estimated_days: 14,
    delay_days: 5,
    is_delayed: 1,
    freight_value: 22.00,
    price: 89.90,
    status: 'delivered'
});
MATCH (c3:Customer {customer_id: 'CUST_3304'}), (o3:Order {order_id: 'ORD_50119'}), (p3:Product {product_id: 'PROD_1003'}), (s3:Seller {seller_id: 'SELLER_114'}), (r3:LogisticsRoute {route_id: 'SP_TO_MG'})
MERGE (c3)-[:PLACED_ORDER]->(o3)
MERGE (o3)-[:CONTAINS_ITEM {quantity: 1, unit_price: 89.90}]->(p3)
MERGE (o3)-[:FULFILLED_BY]->(s3)
MERGE (o3)-[:TRANSPORTED_VIA]->(r3);

MERGE (o4:Order {
    order_id: 'ORD_50220',
    purchase_date: '2017-11-05',
    delivered_date: '2017-11-09',
    actual_delivery_days: 4,
    estimated_days: 12,
    delay_days: 0,
    is_delayed: 0,
    freight_value: 14.80,
    price: 145.00,
    status: 'delivered'
});
MATCH (c4:Customer {customer_id: 'CUST_1088'}), (o4:Order {order_id: 'ORD_50220'}), (p4:Product {product_id: 'PROD_1004'}), (s2:Seller {seller_id: 'SELLER_205'}), (r4:LogisticsRoute {route_id: 'PR_TO_SP'})
MERGE (c4)-[:PLACED_ORDER]->(o4)
MERGE (o4)-[:CONTAINS_ITEM {quantity: 1, unit_price: 145.00}]->(p4)
MERGE (o4)-[:FULFILLED_BY]->(s2)
MERGE (o4)-[:TRANSPORTED_VIA]->(r4);

MERGE (o5:Order {
    order_id: 'ORD_50335',
    purchase_date: '2017-11-15',
    delivered_date: '2017-11-21',
    actual_delivery_days: 6,
    estimated_days: 14,
    delay_days: 0,
    is_delayed: 0,
    freight_value: 28.50,
    price: 189.90,
    status: 'delivered'
});
MATCH (c5:Customer {customer_id: 'CUST_7721'}), (o5:Order {order_id: 'ORD_50335'}), (p1:Product {product_id: 'PROD_1001'}), (s1:Seller {seller_id: 'SELLER_182'}), (r1:LogisticsRoute {route_id: 'SP_TO_RJ'})
MERGE (c5)-[:PLACED_ORDER]->(o5)
MERGE (o5)-[:CONTAINS_ITEM {quantity: 1, unit_price: 189.90}]->(p1)
MERGE (o5)-[:FULFILLED_BY]->(s1)
MERGE (o5)-[:TRANSPORTED_VIA]->(r1);

// ------------------------------------------------------------------------------
// Step 9: Create Reviews & Qualitative Grounding Links
// ------------------------------------------------------------------------------
MERGE (rev1:Review {
    review_id: 'REV_90090',
    score: 1,
    sentiment: 'Negative',
    message_en: 'Table arrived with broken legs and deep scratches. Severe packaging failure.',
    message_pt: 'Mesa chegou com perna quebrada e arranhoes profundos.'
});
MERGE (rev2:Review {
    review_id: 'REV_90074',
    score: 1,
    sentiment: 'Negative',
    message_en: 'Over 30 days delivery delay and hardwood frame was completely cracked upon arrival.',
    message_pt: 'Atraso de mais de 30 dias e a madeira veio toda rachada.'
});
MERGE (rev3:Review {
    review_id: 'REV_90279',
    score: 2,
    sentiment: 'Negative',
    message_en: 'Bedsheet tore on first wash and delivery was 5 days late past the promise date.',
    message_pt: 'O lencol rasgou na primeira lavagem e entrega atrasou.'
});
MERGE (rev4:Review {
    review_id: 'REV_90401',
    score: 5,
    sentiment: 'Positive',
    message_en: 'Ultra-fast delivery in 4 days! Keyboard is genuine, pristine, and impeccably packaged.',
    message_pt: 'Entrega ultra rapida em 4 dias! Teclado original e perfeito.'
});
MERGE (rev5:Review {
    review_id: 'REV_90512',
    score: 1,
    sentiment: 'Negative',
    message_en: 'Missing essential screws to assemble the bookcase. Seller took days to reply.',
    message_pt: 'Faltaram parafusos essenciais para a montagem da estante.'
});

MATCH (o1:Order {order_id: 'ORD_50042'}), (rev1:Review {review_id: 'REV_90090'}), (cause1:ComplaintCause {name: 'damaged_product'})
MERGE (o1)-[:RECEIVES_FEEDBACK]->(rev1)
MERGE (rev1)-[:CITES_COMPLAINT]->(cause1);

MATCH (o2:Order {order_id: 'ORD_50090'}), (rev2:Review {review_id: 'REV_90074'}), (cause1:ComplaintCause {name: 'damaged_product'}), (cause2:ComplaintCause {name: 'delivery_delay'})
MERGE (o2)-[:RECEIVES_FEEDBACK]->(rev2)
MERGE (rev2)-[:CITES_COMPLAINT]->(cause1)
MERGE (rev2)-[:CITES_COMPLAINT]->(cause2);

MATCH (o3:Order {order_id: 'ORD_50119'}), (rev3:Review {review_id: 'REV_90279'}), (cause2:ComplaintCause {name: 'delivery_delay'}), (cause4:ComplaintCause {name: 'poor_quality'})
MERGE (o3)-[:RECEIVES_FEEDBACK]->(rev3)
MERGE (rev3)-[:CITES_COMPLAINT]->(cause2)
MERGE (rev3)-[:CITES_COMPLAINT]->(cause4);

MATCH (o4:Order {order_id: 'ORD_50220'}), (rev4:Review {review_id: 'REV_90401'})
MERGE (o4)-[:RECEIVES_FEEDBACK]->(rev4);

MATCH (o5:Order {order_id: 'ORD_50335'}), (rev5:Review {review_id: 'REV_90512'}), (cause3:ComplaintCause {name: 'missing_parts'})
MERGE (o5)-[:RECEIVES_FEEDBACK]->(rev5)
MERGE (rev5)-[:CITES_COMPLAINT]->(cause3);

// Connect Routes with empirical delay correlations
MATCH (r1:LogisticsRoute {route_id: 'SP_TO_RJ'}), (cause2:ComplaintCause {name: 'delivery_delay'})
MERGE (r1)-[:EXPERIENCES_DELAY_ON {delay_count: 38, avg_delay_days: 11.2}]->(cause2);

MATCH (r2:LogisticsRoute {route_id: 'SP_TO_BA'}), (cause2:ComplaintCause {name: 'delivery_delay'})
MERGE (r2)-[:EXPERIENCES_DELAY_ON {delay_count: 54, avg_delay_days: 15.5}]->(cause2);

MATCH (r1:LogisticsRoute {route_id: 'SP_TO_RJ'}), (cause1:ComplaintCause {name: 'damaged_product'})
MERGE (r1)-[:EXPERIENCES_DAMAGE_ON {damage_count: 29, incident_rate: 0.14}]->(cause1);

MATCH (r2:LogisticsRoute {route_id: 'SP_TO_BA'}), (cause1:ComplaintCause {name: 'damaged_product'})
MERGE (r2)-[:EXPERIENCES_DAMAGE_ON {damage_count: 41, incident_rate: 0.21}]->(cause1);
