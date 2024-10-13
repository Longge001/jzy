@echo off

title �������Ŀ����

rem -------------------------------------------
rem ��������,ÿ����Ŀ��һ��
rem -------------------------------------------

set PROJECT=yy25dlaya

rem -------------------------------------------
rem ��������
rem -------------------------------------------

set MMAKE_PROCESS=50

set GAME_LINE_TITLE="game line"
set CLUSTERS_CENTER_TITLE="clusters center"

set IP=127.0.0.1
set GAME_LINE_PORT=9000
set CLUSTERS_CENTER_PORT=9009

set GAME_NODE_NAME=x10@%IP%
set CLUSTERS_CENTER_NODE_NAME=x_kf_center@%IP%

set PROTO_BUILDER_PATH=../../doc/proto_auto
set PROTO_EDIT_PATH=../../doc/proto_auto

set ERRCDOE_SEARCH_PATH=\"src\"

REM ���õ�ǰbat�Ĺ���
cd ../../
set CUR_CODE_PATH=%cd%
set CUR_ERL_PATH=%CUR_CODE_PATH%\erl

REM ���õ�ǰbat�Ĺ���Ϊȫ��erl��code·��
set SERVER_ERL_PATH=%cd%\erl
set ALL_CODE_PATH=%cd%

REM �ܹ���Ŀ¼
cd ../../../
set TOTAL_PATH=%cd%

rem ��1����erlָ��·�� ERL_PATH=D:\Code\erl7.3\bin\ ��2��Ϊ����ȡ����������erl��·��
set ERL_PATH=

:fun_wait_input
    rem ��configĿ¼Ϊ��׼Ŀ¼
    cd %CUR_ERL_PATH%/config
    set inp=
    echo.
    echo ===============%PROJECT%==================
    echo == TotalPath   %TOTAL_PATH% ==
    echo == CodePath    %ALL_CODE_PATH% ==
    echo == ErlPath     %SERVER_ERL_PATH% ==
    echo 1  su..    seturl         ����·��
    echo 2  o..     open           ���ļ���
    echo 3  upe..   update         svn��erl·��
    echo 4  upa..   update_all     svn��svn���·���������У������ͻ��˴��룩
    echo 5  cm..    commit         �ύ����
    echo 6  cmp..   commit_pt      �ύЭ���ļ�
    echo 7  m..     make           �������˴���
    echo 8  r..     run            ������Ϸ����·
    echo 9  ra..    run2           ����������·����������ģ�
    echo 10 c..     client         �����ͻ���
    echo 11 p..     pt             ����Э��������
    echo 12 e..     errcode        ������(logsĿ¼�����ɴ������ļ�)
    echo 13 s..     stop           �رշ�����
    echo 14 d..     del            ������־
    echo 15 exit..  exit           �������п���̨
	echo 16 clup..  cleanup        svnִ��cleanup
	echo 17 cre..   create         ����ģ����루���ȶ���Э���ļ���
    echo ---------------------------------
    set /p inp=������ָ�
    echo ---------------------------------
    goto fun_routing

:where_to_go
    rem �����Ƿ���������в���
    if [%1]==[] goto fun_wait_input
    goto end

:fun_routing
    if [%inp%]==[seturl] goto fun_set_url_cycle
    if [%inp%]==[open] goto fun_open
    if [%inp%]==[update] goto fun_svn_erl
    if [%inp%]==[update_all] goto fun_svn_all
    if [%inp%]==[commit] goto fun_commit
    if [%inp%]==[commit_pt] goto fun_commit_pt
    if [%inp%]==[make] goto fun_make
    if [%inp%]==[run] goto fun_run
    if [%inp%]==[run2] goto fun_run_all 
    if [%inp%]==[client] goto fun_client_start
    if [%inp%]==[pt] goto fun_proto
    if [%inp%]==[errcode] goto fun_errcode
    if [%inp%]==[stop] goto fun_stop
    if [%inp%]==[del] goto fun_del
    if [%inp%]==[exit] goto end
	if [%inp%]==[cleanup] goto fun_clean_up
	if [%inp%]==[create] goto fun_create

    if [%inp%]==[1] goto fun_set_url_cycle
    if [%inp%]==[2] goto fun_open
    if [%inp%]==[3] goto fun_svn_erl
    if [%inp%]==[4] goto fun_svn_all
    if [%inp%]==[5] goto fun_commit
    if [%inp%]==[6] goto fun_commit_pt
    if [%inp%]==[7] goto fun_make
    if [%inp%]==[8] goto fun_run
    if [%inp%]==[9] goto fun_run_all 
    if [%inp%]==[10] goto fun_client_start
    if [%inp%]==[11] goto fun_proto
    if [%inp%]==[12] goto fun_errcode
    if [%inp%]==[13] goto fun_stop
    if [%inp%]==[14] goto fun_del
    if [%inp%]==[15] goto end
	if [%inp%]==[16] goto fun_clean_up
	if [%inp%]==[17] goto fun_create

    if [%inp%]==[su] goto fun_set_url_cycle
    if [%inp%]==[o] goto fun_open
    if [%inp%]==[upe] goto fun_svn_erl
    if [%inp%]==[upa] goto fun_svn_all
    if [%inp%]==[cm] goto fun_commit
    if [%inp%]==[cmp] goto fun_commit_pt
    if [%inp%]==[m] goto fun_make
    if [%inp%]==[r] goto fun_run
    if [%inp%]==[ra] goto fun_run_all 
    if [%inp%]==[c] goto fun_client_start
    if [%inp%]==[p] goto fun_proto
    if [%inp%]==[e] goto fun_errcode
    if [%inp%]==[s] goto fun_stop
    if [%inp%]==[d] goto fun_del
    if [%inp%]==[exit] goto end
	if [%inp%]==[clup] goto fun_clean_up
	if [%inp%]==[cre] goto fun_create
    goto where_to_go

:fun_create
    start cmd /k "cd /d %ALL_CODE_PATH%\tool\ErlTmpCreate\dist && main.exe"
    goto where_to_go

:fun_open
    explorer %ALL_CODE_PATH%
    goto where_to_go

:fun_svn_all
    start TortoiseProc /command:update /path:%ALL_CODE_PATH%
    goto where_to_go

:fun_svn_erl
    start TortoiseProc /command:update /path:%SERVER_ERL_PATH%
    goto where_to_go

:fun_commit
    start TortoiseProc /command:commit /path:"%SERVER_ERL_PATH%\src*%SERVER_ERL_PATH%\include*%SERVER_ERL_PATH%\sql"
    goto where_to_go

:fun_commit_pt
    start TortoiseProc /command:commit /path:"%ALL_CODE_PATH%\doc\proto_auto"
    goto where_to_go

:fun_clean_up
	start TortoiseProc /command:cleanup /path:"%ALL_CODE_PATH%"
	goto where_to_go

:fun_make
    echo �Եȼ�����
    cd %SERVER_ERL_PATH%
    %ERL_PATH%erl -pa ./ebin -noshell -eval "mmake:all(%MMAKE_PROCESS%), init:stop()"
    goto where_to_go

:fun_run
    ::start %GAME_LINE_TITLE% erl +P 1024000 +K true -smp true -name %GAME_NODE_NAME% -setcookie gsrv -boot start_sasl -config gsrv -pa ../ebin -s gsrv start -s reloader start -extra %IP% %GAME_LINE_PORT% 10
    cd %SERVER_ERL_PATH%/script/
    start gs10.bat %ERL_PATH%
    goto where_to_go
    
:fun_run_all
    ::start %CLUSTERS_CENTER_TITLE% erl +P 1024000 +K true -smp true -name %CLUSTERS_CENTER_NODE_NAME% -setcookie x_kf_center -boot start_sasl -config cls -pa ../ebin -s gsrv start -s reloader start -extra %IP% %CLUSTERS_CENTER_PORT% 0
    ::ping -n 3 127.0.0.1>nul
    ::start %GAME_LINE_TITLE% erl +P 1024000 +K true -smp true -name %GAME_NODE_NAME% -setcookie gsrv -boot start_sasl -config gsrv -pa ../ebin -s gsrv start -s reloader start -extra %IP% %GAME_LINE_PORT% 10
    cd %SERVER_ERL_PATH%/script/
    start gs10.bat %ERL_PATH%
    ping -n 3 127.0.0.1>nul
    start center.bat %ERL_PATH%
    REM cd %KF_ERL_PATH%/script/
    goto where_to_go

:fun_client_start
    start cmd /k "cd/d %ALL_CODE_PATH%\u3d\app\localTest && ClientApp.exe"
    goto where_to_go
    
:fun_proto
    start cmd /k "cd %PROTO_BUILDER_PATH% && ProtoBuilder.bat"
    goto where_to_go

:fun_errcode
    cd ../
    set errcode_pt=
    set /p errcode_pt=������Э�飺
    %ERL_PATH%erl -pa ./ebin -noshell -eval "tool:create_error_code_sql(%ERRCDOE_SEARCH_PATH%, %errcode_pt%), init:stop()"
    cd config
    goto where_to_go
    
:fun_stop
    start %ERL_PATH%erl -noshell -name center_stop@%IP% -setcookie gsrv -eval "rpc:cast('%CLUSTERS_CENTER_NODE_NAME%', gsrv, stop, []), init:stop()"
    start %ERL_PATH%erl -noshell -name game_stop@%IP% -setcookie gsrv -eval "rpc:cast('%GAME_NODE_NAME%', gsrv, stop, [])"
    taskkill /F /IM erl.exe
    goto where_to_go
    
:fun_del
    cd ../logs/
    del /f /s /q  *
    goto where_to_go

:fun_set_url_cycle
    call :fun_set_url
    goto where_to_go

:fun_set_url
    set /p loc=���������:
    set subloc=
    set /p subloc=����ƽ̨:
    if [%subloc%]==[] (
        set subloc=%loc%
    )
    REM �ṹ:��Ŀ����svn����ͬһ��Ŀ¼������Ч
    if [%loc%]==[%subloc%] (
        set SERVER_ERL_PATH=%TOTAL_PATH%\%PROJECT%_%loc%\trunk\code\erl\
        set ALL_CODE_PATH=%TOTAL_PATH%\%PROJECT%_%loc%\trunk\code
    ) else (
        set SERVER_ERL_PATH=%TOTAL_PATH%\%PROJECT%_%loc%\%subloc%\code\erl\
        set ALL_CODE_PATH=%TOTAL_PATH%\%PROJECT%_%loc%\%subloc%\code
    )

:end