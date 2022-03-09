# installed-patches

Script utilizado para coletar a lista de pacotes instalados no servidor. Será coletado a saida do comando: rpm -qa --lat

Como utilizar:

1 - Edite o arquivo server_list.txt e adicione a lista de servidores que deseja transferir o arquivo.

2 - Execute o script scp-remoto.sh: ./installed-packages-evidence.sh

3 - Será solicitado o nome do ID remoto
Ex.:
Please inform the remote ID to scan the server:
root

4 - Após ser finalizado, será criado um arquivo para cada servidor escaneado no diretório result_scan/DATA com o seguinte padrão
NOME-SERVIDOR_installed_packages.txt

4.1 - Caso o escaneamento seja concluida com sucesso, temos a seguinte mensagem:
Ex.:
Server: servidor1.abc.xzy
SUCCESS.: SUCCESS.: Scan completed successfully in the servidor1.abc.xzy

4.2 - Caso ocorra algum erro durante a transferência, temos a seguinte mensagem:
Ex.:
Server: servidor1.abc.xzy
ERROR.: Scan fail in the servidor1.abc.xzy. Please contact the System Admin.
