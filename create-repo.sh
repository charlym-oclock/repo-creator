#!/bin/bash
# -*- ENCODING: UTF-8 -*-

Github_Personnal_Access_Token="A RENSEIGNER"
user_name="A RENSEIGNER"


echo "Saisir le chemin de votre dossier. Si le dossier n'existe pas, il sera automatiquement créé."
read abspath
if [ ! -d $abspath ]
then
    mkdir $abspath
fi
while true; do
    read -p "Le dossier concerné est bien ${abspath}? (Y/N)" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) echo "Alors il y a un soucis avec le chemin du dossier, on recommence ;)"; exit;;
        * ) echo "Répondre par Y or N.";;
    esac
done
cd $abspath
git init
touch README.md
echo "Saisir une description a mettre dans votre fichier README.md"
read description
echo $description >> README.md
git diff
git add README.md
git status
while true; do
    read -p "Le fichier est-il bien ajouté au repo local? (Y/N)" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) echo "Alors on recommence"; exit;;
        * ) echo "Répondre par Y or N.";;
    esac
done

process_push(){
    git commit -m "Initial commit"
    git remote add origin git@github.com:${user_name}/${repo_name}.git
    curl -u ${user_name}:${Github_Personnal_Access_Token} https://api.github.com/user/repos -d {\"name\":\"${repo_name}\"} #this will create the repo in github.
    git push --set-upstream origin master
    exit
}
echo "Saisir le nom du repository a créer :"
read repo_name
echo $user_name, $repo_name

while true; do
    read -p "Les infos ci-dessus sont-elles correctes ? (Y/N)" yn
    case $yn in
        [Yy]* ) process_push ;;
        [Nn]* ) echo "Alors on recommence depuis le début T^T "; exit;;
        * ) echo "Répondre par Y or N.";;
    esac
done

