*** Settings ***
Documentation        Acessar pagina de cadastro do instagram
...                  Cadastrar usuario no instagram

Resource             ../ResourceInstagram/ResourceCadastro.robot

*** Test Case ***
Test Case 01: Acessar pagina de cadastro do instagram
  [Documentation]   Acessar pagina de cadastro do instagram
  [Tags]            pagina_instagram
  
  Given Acessar pagina de cadastro do instagram

Test Case 02: Cadastrar usuario no instagram
  [Documentation]   Cadastrar usuario no instagram
  [Tags]            cadastroUsuario_instagram

  Given Verificar se os campos do cadastro estão visiveis 
  When Preencher campos para cadastro 
  And Cadastrar
  And Verificar se os campos de data nascimento estão visiveis
  And Inserir data de nascimento
  Then Confirmar cadastro