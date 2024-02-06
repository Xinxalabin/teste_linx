*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem

*** Variables ***
${BROWSER}          chrome
${URL}              https://www.linx.com.br

*** Test Cases ***
Acessar e verificar filiais e segmentos
    Abrir navegador e acessar o site da Linx
    Verificar filial CASCAVEL/PR
    Verificar ausência de filial APARECIDA DE GOIANIA
    Voltar à página inicial
    Acessar carreiras da Linx
    Filtrar segmento Linx - Tecnologia e produto
    Verificar ausência do segmento Linx - Suporte
    Verificar segmento filtrado

*** Keywords ***
Abrir navegador e acessar o site da Linx
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Verificar filial CASCAVEL/PR
    Click Element    xpath://a[contains(text(),'Institucional')]
    Click Element    xpath://a[contains(text(),'Matriz e filiais')]
    Wait Until Page Contains Element    xpath=//h3[@class='o-title c-address-list__title' and contains(text(),'Cascavel/PR')]
    Log    Filial CASCAVEL/PR encontrada
     Execute JavaScript    window.scrollBy(0, 500)
    Run Keyword And Continue On Failure    Capture Page Screenshot   

Verificar ausência de filial APARECIDA DE GOIANIA
    Run Keyword     Element Should Not Be Visible    xpath://div[contains(text(),'APARECIDA DE GOIANIA')]
    Log    Filial APARECIDA DE GOIANIA não encontrada

Voltar à página inicial
    Wait Until Page Contains Element    xpath=//img[@alt='Linx']    timeout=30s
    Click Element    xpath=//img[@alt='Linx']
    Log    Elemento img com atributo alt "Linx" clicado com sucesso
    Run Keyword And Continue On Failure    Capture Page Screenshot

Acessar carreiras da Linx
    Click Element    xpath://a[contains(text(),'Institucional')]
    Click Element    xpath://a[contains(text(),'Carreira Linx')]
    Run Keyword And Continue On Failure    Capture Page Screenshot

Filtrar segmento Linx - Tecnologia e produto
    Click Element    id=greenouse-segments
    Select From List by Value    xpath=//select[@id='greenouse-segments']    Linx - Tecnologia e Produto 
    Log    Opção 'Linx - Tecnologia e Produto' selecionada com sucesso  
    Run Keyword And Continue On Failure    Capture Element Screenshot    xpath=//select[@id='greenouse-segments']

Verificar ausência do segmento Linx - Suporte
    Run Keyword    Element Should Not Be Visible    xpath://label[contains(text(),'Linx - Suporte')]
    Log    Segmento Linx - Suporte não encontrado

Verificar segmento filtrado
    ${selected_option} =    Get Selected List Value    id=greenouse-segments
    Element Attribute Value Should Be    id=greenouse-segments    value    Linx - Tecnologia e Produto
    Log    Opção 'Linx - Tecnologia e Produto' selecionada com sucesso
    Run Keyword And Continue On Failure    Capture Page Screenshot
