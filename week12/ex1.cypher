CREATE
(f1:Fighter {name:"Khabib Nurmagomedov",weight:"155"}),
(f2:Fighter {name:"Rafael Dos Anjos",weight:"155"}),
(f3:Fighter {name:"Neil Magny",weight:"170"}),
(f4:Fighter {name:"Jon Jones",weight:"205"}),
(f5:Fighter {name:"Daniel Cormier",weight:"205"}),
(f6:Fighter {name:"Michael Bisping",weight:"185"}),
(f7:Fighter {name:"Matt Hamill",weight:"185"}),
(f8:Fighter {name:"Brandon Vera",weight:"205"}),
(f9:Fighter {name:"Frank Mir",weight:"230"}),
(f10:Fighter {name:"Brock Lesnar",weight:"230"}),
(f11:Fighter {name:"Kelvin Gastelum",weight:"185"}),

(f1)-[:beats]->(f2),
(f2)-[:beats]->(f3),
(f4)-[:beats]->(f5),
(f6)-[:beats]->(f7),
(f4)-[:beats]->(f8),
(f8)-[:beats]->(f9),
(f9)-[:beats]->(f10),
(f3)-[:beats]->(f11),
(f11)-[:beats]->(f6),
(f6)-[:beats]->(f7),
(f6)-[:beats]->(f11),
(f7)-[:beats]->(f4);
