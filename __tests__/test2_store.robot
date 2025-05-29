*** Settings ***
Library    RequestsLibrary

*** Variables ***
${url}    https://petstore.swagger.io/v2/store/order

${id}    184409097                
${petId}    2
${quantity}    1
${shipDate}    2025-05-29T17:18:33.166+0000
${status}    placed
${complete}    true


*** Test Cases ***
Post store
    ${body}    Create Dictionary    id=${id}    petId=${petId}    quantity=${quantity}
    ...    shipDate=${shipDate}    status=${status}    complete=${complete}
    ${response}    POST    url=${url}    json=${body}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}         

    Status Should Be    200
    Should Be Equal    ${response_body}[id]                  ${{int($id)}}
    Should Be Equal    ${response_body}[petId]               ${{int($petId)}}
    Should Be Equal    ${response_body}[quantity]            ${{int($quantity)}}
    Should Be Equal    ${response_body}[shipDate]            ${shipDate}
    Should Be Equal    ${response_body}[status]              ${status}
    Should Be Equal    ${response_body}[complete]            ${true}


Get store
    ${response}    GET    ${{$url + '/' + $id}}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]                  ${{int($id)}}
    Should Be Equal    ${response_body}[petId]               ${{int($petId)}}
    Should Be Equal    ${response_body}[quantity]            ${{int($quantity)}}
    Should Be Equal    ${response_body}[shipDate]            ${shipDate}
    Should Be Equal    ${response_body}[status]              ${status}
    Should Be Equal    ${response_body}[complete]            ${true}


Delete store
    ${response}    DELETE    ${{$url + '/' + $id}}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]    ${{int(200)}}
    Should Be Equal    ${response_body}[type]    unknown
    Should Be Equal    ${response_body}[message]    ${id}


