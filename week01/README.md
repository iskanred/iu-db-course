# DB-Course

### Authors
BS20-02

Khabib Khaysadykov, k.khaysadykov@innopolis.university

Adela Krylova, a.krylova@innopolis.university

Artyom Chernitsa, a.chernitsa@innopolis.university

Artem Murashko, ar.murashko@innopolis.university

Iskander Nafikov, i.nafikov@innopolis.university

### Client Asssumptions
1. Each Artist should have ID key attribute
2. Album should be identified based on its Artist and Name
3. Track should be identified based on its Album and Name
4. Finally it means, that this is weak entities and relations between them. That's why Name attribute of Track is partial key attribute and the Name of Album too.
5. Besides, there is only strict condition that Track can't exist without Album. Every Artist can have a lot of Albums.

### Diagram
![alt text](./diagram.jpg)
