# DB-Course

### Authors
<br>BS20-02

Khabib Khaysadykov, k.khaysadykov@innopolis.university

Adela Krylova, a.krylova@innopolis.university

Artyom Chernitsa, a.chernitsa@innopolis.university

Artem Murashko, ar.murashko@innopolis.university

Iskander Nafikov, i.nafikov@innopolis.university

### Client Asssumptions
    <br>Each Artist should have ID key attribute
    <br>Album should be identified based on its Artist and Name
    <br>Track should be identified based on its Album and Name
    <br>Finally it means, that this is weak entities and relations between them. That's why Name attribute of Track is partial key attribute and the Name of Album too.
    <br>Besides, there is only strict condition that Track can't exist without Album. Every Artist can have a lot of Albums.

### Diagram
![alt text](./diagram.jpg)
