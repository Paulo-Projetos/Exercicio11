*** Settings ***
Library    RequestsLibrary

*** Variables ***
${url}    https://petstore.swagger.io/v2/user

${id}            184409097
${username}      Tobias         


*** Test Cases ***
# Alterando as funções Post e Delete, para execução dos testes a partir de um json dinamico:
Post user
    ${body}    Evaluate    json.loads(open('./fixtures/pet3.json').read())
    ${response}    POST    url=${url}    json=${body}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

# Efetuando test de conexão com o git hub
    Status Should Be    200
    Should Be Equal    ${response_body}[code]            ${{int(200)}}
    Should Be Equal    ${response_body}[type]            unknown
    Should Be Equal    ${response_body}[message]         ${id}

Delete user
    ${response}    DELETE    ${{$url + '/' + $username}}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]        ${{int(200)}}
    Should Be Equal    ${response_body}[type]        unknown
    Should Be Equal    ${response_body}[message]     ${username}



