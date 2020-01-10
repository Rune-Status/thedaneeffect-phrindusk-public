rm -rf .git
git init
git add .
git commit -m "History cleared"
git remote add origin git@github.com:thedaneeffect/phrindusk-public.git
git push -u --force origin master