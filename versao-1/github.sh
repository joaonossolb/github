#! /bin/bash
nomescript=$(echo "$0" | cut -d "/" -f2 | cut -d "." -f1)
#FUNÇÃO QUE MOSTRA UMA MENSAGEM VAZIA, VAI SER USADA PARA FAZER ESPAÇOS ENTRE OS TEXTOS QUE O SCRIPT MOSTRA
vazio(){
echo ""
}

echo -e " \033[01;31m \n
 			  ____ ___ _____   _   _ _   _ ____  
 			 / ___|_ _|_   _| | | | | | | | __ ) 
			| |  _ | |  | |   | |_| | | | |  _ \ 
			| |_| || |  | |   |  _  | |_| | |_) |
 			 \____|___| |_|   |_| |_|\___/|____/ 
                                     

\033[00;37m"

#FUNÇÃO QUE VAI  MOSTRAR COMO USA O SCRIPT, E OUTRAS INFORMAÇÕES
topo(){
	echo "Git Hub facilita a vida dos programadores colocando seus codigos no github de forma automatizada"
	vazio
	echo -e " \033[01;31m \nATENÇÃO: O SCRIPT DEVE ESTAR JUNTO COM OS ARQUIVOS QUE VOCÊ QUER COLOCAR NO REPOSITÓRIO DO github.com NÃO SE PREOCUPE, $nomescript NÃO VAI SER COLOCADO JUNTO COM SEUS SCRIPTS NO GITHUB.COM\033[00;37m"
	vazio
	echo "$0 git --> Para Executar o script por completo"
	echo -e " \033[01;31m \n Desenvolvedor: João Alexandre Nossol Balbino \033[00;37m"
	echo -e " \033[01;31m \n https://github.com/joaonossolb \033[00;37m"
	vazio

}
#FUNÇÃO QUE VAI MOSTRAR AS MENSAGENS E OPÇÃO DE DIGITAR PARA O USUARIO (PERGUNTA 1)
opc1(){

		echo "Digite ou cole a URL da pasta em que deseja colocar o seu script" 
		echo "Exemplo: https://github.com/joaonossolb/sourceskali"
		read folder
		if [ -z "$folder" ];then opc1; fi
}
#FUNÇÃO QUE VAI MOSTRAR AS MENSAGENS E OPÇÃO DE DIGITAR PARA O USUARIO (PERGUNTA 2)
opc2(){

		echo "Digite o nome da commit"
		read cm
		if [ -z "$cm" ];then opc2; fi

}
argumentos(){
		if [ -z "$1" ];then
		topo #EXECUTA A FUNÇÃO topo
		fi # FIM DO if[ -z $1 ]

		if [ "$1" != "" ] && [ "$1" != "git" ];then
		topo #EXECUTA A FUNÇÃO TOPO
		fi
}
#FUNÇÃO PRINCIPAL DO PROGRAMA
main(){
		argumentos $1
		if [ "$1" == "git" ];then #SE O PRIMEIRO ARGUMENTO FOR git, (sem virgula) ENTÃO O SCRIPT VAI EXECUTAR POR COMPLETO
	if [ -f "/usr/bin/git" ];then # ESSA LINHA VERIFICA SE O BINARIO DO git ESTÁ INSTALADO
	opc1 #SE A CONDIÇÃO ACIMA FOR TRUE, ENTÃO VAI EXECUTAR A FUNÇÃO opc1 E A FUNÇÃO opc2
	opc2
	echo "Iniciando..."
	git init # INICIALIZAÇÃO DO GIT
	eliminaup=$(echo "$0" | cut -d "/" -f2) # ESSA LINHA PEGA O NOME DO SCRIPT github, MESMO SE SE TIVER TROCADO O NOME DELE

		if [ -d "/tmp" ];then # ESSA LINHA VERIFICA SE A PASTA TMP EXISTE
		verscripts=$(ls | grep -v "$eliminaup" > /tmp/scripts.tmp) #ESSA LINHA VÊ OS SCRIPTS QUE ESTÃO NA PASTA, ELIMINA O SCRIPT github PARA QUE ELE NÃO SEJA UPADO NO GITHUB JUNTO COM SEUS SCRIPTS  E DEPOIS SALVA OS NOMES DOS ARQUIVOS DA PASTA EM QUE O SCRIPT ESTÁ EXECUTANDO, DENTRO DA PASTA /tmp E SALVA COM O NOME scripts.tmp
			else #ESSA LINHA É EXECUTADA, CASO NÃO POSSUA A PASTA /tmp
				echo "Você não possui a pasta /tmp"
				break #ESSE COMANDO FINALIZA A EXECUÇÃO DO SCRIPT, JÁ QUE NÃO É POSSÍVEL EXECUTA-LO SEM A PASTA /tmp
		fi #FIM DO if [ -d "/tmp" ];then

	for script in $(cat /tmp/scripts.tmp);do # ESSA LINHA VAI LER O ARQUIVO GERADO NA PASTA /tmp
	git add $script #ESSE COMANDO VAI INSERIR OS SCRIPTS PARA SEREM ADICIONADOS AO SEU REPOSITÓRIO DO GITHUB
	done

	echo "Adicionando a Commit"
	git commit -m $cm
	echo "Aguarde..."
	git remote add origin $folder".git"

	git push -u origin master
		if [ "$?" == 0 ];then #ESSA LINHA VAI VERIFICAR SE O ULTIMO COMANDO(git push -u origin master) FOI REALIZADO COM SUCESSO, SE SIM, VAI RETORNAR 0, SE NÃO, VAI RETORNAR 127
		echo "Script Enviado com sucesso para o github :)"

		else
		rm .git/ -rf
		echo -e " \033[01;31m \n Ocorreu algum erro :( \033[00;37m"
		vazio
		fi

	else
		echo -e " \033[01;31m \n Instale o GIT no linux para conseguir usar o script \033[00;37m"
		break #FINALIZA O SCRIPT
	
	fi # FIM DO if [ -z $1 ];then
	fi #FIM DO if [ -f /usr/bin/git ];then
		
}

# FUNÇÃO QUE VAI VERIFICAR SE O USUARIO É root
root(){
	if [ "$USER" == "root" ];then #ESSA LINHA VERIFICA SE O USUÁRIO É root
		main $1 #SE SIM, VAI EXECUTAR A FUNÇÃO PRINCIPAL DO PROGRAMA (main) E PASSAR O ARGUMENTO 1

	else #CASO CONTRÁRIO, IRÁ EXECUTAR A LINHA ABAIXO
		echo -e " \033[01;31m \n PRECISA SER USUÁRIO root PARA EXECUTAR O SCRIPT\033[00;37m"
		vazio #EXECUTA A FUNÇÃO vazio PARA DEIXAR NÃO DEIXAR OS TEXTOS JUNTOS
		topo #EXECUTA A FUNÇÃO topo PARA MOSTRAR COMO USA O SCRIPT E OUTRAS INFORMAÇÕES
	fi #FIM if [ $USER == root ];then

}

#EXECUTA A FUNÇÃO root QUE IRÁ DECIDIR O FUNCIONAMENTO DO SCRIPT
root $1
