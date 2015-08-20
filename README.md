When you set your first foot into a pristine virtual machine/server/.., have
you ever wanted torun a single command and have all your familiar config files
and software installed for you while you drink coffee?

Quick-deploy is a tiny script that scratches that itch.
It takes as input a directory chocked full of your files and an bash script
(usually, containing an apt-get for your favorite editor), and generates a single
installer script. You can put this script on your favorite server (or, Github).
When you get on a fresh VM, you can then just

```bash
wget http://domain.com/install.sh | bash
```
And get your files back, and your programs installed in no time.

![quick-deploy]*(showcase.git)

