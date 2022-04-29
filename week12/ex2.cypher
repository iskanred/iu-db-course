MATCH (p:Fighter)-[:beats]->() WHERE (p.weight = "155" or p.weight = "170" or p.weight = "185") RETURN p;

MATCH (p:Fighter)-[:beats]->(pp:Fighter)-[:beats]->(p) RETURN p, pp;

MATCH (f1:Fighter)-[:beats]->(f2:Fighter)-[:beats*1..]->(f3:Fighter) WHERE f1.name = "Khabib Nurmagomedov" RETURN f3;

MATCH (f1:Fighter)-[:beats*]->(f2:Fighter) WHERE not ()-[:beats]->(f1) RETURN f1;

MATCH (f1:Fighter)-[:beats*]->(f2:Fighter) WHERE not (f2)-[:beats]->() RETURN f2;


MATCH (f:Fighter)
SET f.wins = size((f)-[:beats]->()), f.loses = size(()-[:beats]->(f))
RETURN f, size((f)-[:beats]->()) as wins, size(()-[:beats]->(f)) as loses;
