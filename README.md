# escalatable

escalatable is a vulnerable Linux machine to practice Linux privilege escalation techniques

this machine contains 10 users. participants start from user0 and the goal is to reach user10 (focusing on bash and sudo)

as users go further the level will get harder.

# setup

```bash
sudo docker run -p 2222:22 --name escalatable kooroshrz/escalatable:v1
```
