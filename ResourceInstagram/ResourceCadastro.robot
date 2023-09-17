*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${URL}                          https://www.instagram.com/accounts/emailsignup
${BROWSER}                      chrome
@{FIELD_FORM}                   emailOrPhone    fullName    username    password
&{VALUES_FORM}
...                             email=ralox80983@vip4e.com
...                             nome=Emilia Santos Sousa
...                             usuario=emiliasantossousademortyaisk8ljjwdte
...                             senha=Emilia@teste123
${BUTTON_CADASTRAR}             //button[@class='_acan _acap _acas _aj1-'][contains(.,'Cadastre-se')]
@{FIELD_DATA_NASCIMENTO}        Mês    Dia    Ano
&{VALUES_DADOS_NASCIMENTO}
...                             mes=//option[@title='junho'][contains(.,'junho')]
...                             dia=//option[@title='8'][contains(.,'8')]
...                             ano=//option[@title='1993'][contains(.,'1993')]
${BUTTON_AVANCAR1}              //button[@class='_acan _acap _acaq _acas _aj1-'][contains(.,'Avançar')]


*** Keywords ***
# Test Case 01

Acessar pagina de cadastro do instagram
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains    Cadastre-se para ver fotos e vídeos dos seus amigos.

# Test Case 02

Verificar se os campos do cadastro estão visiveis
    FOR    ${FIELD}    IN    @{FIELD_FORM}
        ${Status}    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    xpath=//input[@name=((i), '${FIELD}')]
    END

Preencher campos para cadastro
    FOR    ${FIELD}    IN    @{FIELD_FORM}
        IF    '${FIELD}'=='emailOrPhone'
            Input Text    xpath=//input[@name=('emailOrPhone')]    ${VALUES_FORM.email}
        ELSE IF    '${FIELD}'=='fullName'
            Input Text    xpath=//input[@name=('fullName')]    ${VALUES_FORM.nome}
        ELSE IF    '${FIELD}'=='username'
            Input Text    xpath=//input[@name=('username')]    ${VALUES_FORM.usuario}
        ELSE
            Input Text    xpath=//input[@name=('password')]    ${VALUES_FORM.senha}
        END
    END

Cadastrar
    Wait Until Element Is Visible    ${BUTTON_CADASTRAR}
    Scroll Element Into View    ${BUTTON_CADASTRAR}
    Wait Until Element Is Enabled    ${BUTTON_CADASTRAR}
    Page Should Contain
    ...    Ao se cadastrar, você concorda com nossos Termos, Política de Privacidade e Política de Cookies.
    Element Should Be Enabled    ${BUTTON_CADASTRAR}
    Click Element    ${BUTTON_CADASTRAR}

Verificar se os campos de data nascimento estão visiveis
    Sleep    8 seconds
    Page Should Contain    Adicione sua data de nascimento
    FOR    ${FIELD_NASCIMENTO}    IN    @{FIELD_DATA_NASCIMENTO}
        ${Status}    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    xpath=//select[contains(@title,((i), '${FIELD_NASCIMENTO}'))]
    END

Inserir data de nascimento
    FOR    ${FIELD_SELECT}    IN    @{FIELD_DATA_NASCIMENTO}
        IF    '${FIELD_SELECT}'=='Mês'
            Click Element    xpath=//select[contains(@title,'Mês')]
            Wait Until Element Is Visible    ${VALUES_DADOS_NASCIMENTO.mes}
            Click Element    ${VALUES_DADOS_NASCIMENTO.mes}
        ELSE IF    '${FIELD_SELECT}'=='Dia'
            Click Element    xpath=//select[contains(@title,'Dia')]
            Wait Until Element Is Visible    ${VALUES_DADOS_NASCIMENTO.dia}
            Click Element    ${VALUES_DADOS_NASCIMENTO.dia}
        ELSE
            Click Element    xpath=//select[contains(@title,'Ano')]
            Wait Until Element Is Visible    ${VALUES_DADOS_NASCIMENTO.ano}
            Click Element    ${VALUES_DADOS_NASCIMENTO.ano}
        END
    END
    Wait Until Element Is Visible    ${BUTTON_AVANCAR1}
    Click Element    ${BUTTON_AVANCAR1}

Confirmar cadastro
    Sleep    8 seconds
    Page Should Contain    Inserir código de confirmação

    # continuar a partir daqui
    # Execute Javascript    window.open() para pegar o código no e-mail, alias será interessante.
