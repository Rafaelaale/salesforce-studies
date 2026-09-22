# Estudo Completo — Aura Lightning Components

---

## Capítulo 2 (continuação) — SLDS vs CSS próprio

### Quando usar classes SLDS (Salesforce Lightning Design System)

Use SLDS quando:
- O elemento é padrão de UI (botão, card, grid, formulário, ícone, badge, spinner).
- Você quer manter consistência visual com o restante do Salesforce (Setup, Lightning Experience).
- Precisa de responsividade pronta (`slds-grid`, `slds-col`, `slds-size_1-of-2`).
- Quer evitar manutenção de CSS customizado (menos código, menos bugs visuais).
- O componente será usado por usuários finais dentro do Salesforce (eles já reconhecem o padrão visual).

Exemplo:
```html
<div class="slds-card slds-p-around_medium">
    <lightning:button label="Salvar" variant="brand" class="slds-m-top_small"/>
</div>
```

### Quando usar CSS próprio

Use CSS customizado (arquivo `.css` do componente) quando:
- Precisa de um layout específico que o SLDS não cobre (grid customizado, animações, posicionamento absoluto).
- Precisa de branding específico do cliente (cores, fontes fora do padrão SLDS).
- Precisa sobrescrever comportamento visual de um componente padrão (com cuidado, pois classes internas do SLDS podem mudar entre releases).
- O componente é standalone (ex: página pública, Experience Cloud com tema próprio).

**Regra prática:** combine os dois — use SLDS como base estrutural (grid, espaçamento, cores de estado) e CSS próprio apenas para o que for exclusivo do seu componente. Nunca recrie do zero o que o SLDS já resolve (botão, ícone, card), pois isso quebra a consistência e aumenta o custo de manutenção.

**Erro comum:** sobrescrever classes SLDS diretamente (`.slds-button { ... }`) no CSS do componente — isso afeta apenas o componente por causa do escopo do Aura CSS, mas gera confusão porque parece que deveria ser global. Prefira criar sua própria classe e combiná-la com a do SLDS.

---

## Capítulo 3 — Componentes Aura padrão

Para cada componente: finalidade, atributos principais, eventos, exemplo, quando usar, erros comuns.

### `lightning:button`
- **Finalidade**: botão de ação padrão.
- **Atributos principais**: `label`, `variant` (`brand`, `destructive`, `neutral`, `success`), `iconName`, `disabled`, `onclick`.
- **Eventos**: `onclick`.
- **Exemplo**:
```html
<lightning:button label="Salvar" variant="brand" onclick="{!c.handleSave}"/>
```
- **Quando usar**: qualquer ação disparada pelo usuário (salvar, cancelar, buscar).
- **Erros comuns**: esquecer de referenciar a função no Controller (`c.handleSave` sem existir no `Controller.js`); usar `variant` inválida (case sensitive).

### `lightning:buttonIcon`
- **Finalidade**: botão apenas com ícone, sem texto.
- **Atributos principais**: `iconName`, `variant`, `alternativeText` (obrigatório para acessibilidade), `onclick`.
- **Exemplo**:
```html
<lightning:buttonIcon iconName="utility:delete" alternativeText="Remover" onclick="{!c.handleDelete}"/>
```
- **Quando usar**: ações compactas em listas/tabelas (editar, remover, expandir).
- **Erros comuns**: omitir `alternativeText` (falha de acessibilidade e warning no console).

### `lightning:input`
- **Finalidade**: campo de entrada genérico (texto, número, data, checkbox, etc. via `type`).
- **Atributos principais**: `label`, `name`, `value`, `type`, `required`, `disabled`, `onchange`.
- **Exemplo**:
```html
<lightning:input label="Nome" name="nome" value="{!v.nome}" required="true"/>
```
- **Quando usar**: campos simples sem necessidade de metadata do objeto Salesforce.
- **Erros comuns**: não usar two-way binding (`{!v.atributo}`) e depois tentar ler o valor errado no Controller; esquecer `required` e permitir submissão inválida.

### `lightning:textarea`
- **Finalidade**: campo de texto multilinha.
- **Atributos principais**: `label`, `value`, `maxlength`, `onchange`.
- **Exemplo**:
```html
<lightning:textarea label="Observações" value="{!v.observacoes}"/>
```
- **Quando usar**: descrições, comentários, textos longos.
- **Erros comuns**: não validar tamanho máximo antes de enviar ao Apex (limite do campo no objeto pode ser menor).

### `lightning:select`
- **Finalidade**: combobox/dropdown nativo.
- **Atributos principais**: `label`, `value`, `onchange` (opções via `<option>` interno).
- **Exemplo**:
```html
<lightning:select label="Status" value="{!v.status}" onchange="{!c.handleStatusChange}">
    <option value="Ativo">Ativo</option>
    <option value="Inativo">Inativo</option>
</lightning:select>
```
- **Quando usar**: lista curta e fixa de opções.
- **Erros comuns**: usar `lightning:select` quando a lista vem dinâmica do Apex sem popular as `<option>` via `aura:iteration`.

### `lightning:checkboxGroup`
- **Finalidade**: grupo de checkboxes com múltipla seleção.
- **Atributos principais**: `label`, `options` (lista de `{label, value}`), `value` (array de selecionados), `onchange`.
- **Exemplo**:
```html
<lightning:checkboxGroup label="Interesses" options="{!v.opcoes}" value="{!v.selecionados}"/>
```
- **Quando usar**: múltiplas escolhas não exclusivas.
- **Erros comuns**: passar `options` no formato errado (precisa ser lista de objetos com `label`/`value`).

### `lightning:card`
- **Finalidade**: container visual padrão com título, ícone e ações.
- **Atributos principais**: `title`, `iconName`, `class` (para slot de ações no header).
- **Exemplo**:
```html
<lightning:card title="Alunos" iconName="standard:contact">
    <p class="slds-p-horizontal_small">Conteúdo aqui</p>
</lightning:card>
```
- **Quando usar**: agrupar visualmente uma seção da interface.
- **Erros comuns**: colocar `lightning:card` dentro de outro `lightning:card` sem necessidade, criando aninhamento visual estranho.

### `lightning:icon`
- **Finalidade**: exibir ícones do SLDS.
- **Atributos principais**: `iconName` (ex: `standard:account`, `utility:success`), `size`, `variant`.
- **Exemplo**:
```html
<lightning:icon iconName="utility:success" size="small" variant="success"/>
```
- **Quando usar**: reforço visual de estado (sucesso, erro, aviso).
- **Erros comuns**: usar nome de ícone inexistente (falha silenciosa, não renderiza).

### `lightning:spinner`
- **Finalidade**: indicador de carregamento.
- **Atributos principais**: `alternativeText`, `size`, `variant`.
- **Exemplo**:
```html
<aura:if isTrue="{!v.carregando}">
    <lightning:spinner alternativeText="Carregando" size="medium"/>
</aura:if>
```
- **Quando usar**: durante chamadas assíncronas ao Apex.
- **Erros comuns**: esquecer de setar `carregando = false` no callback (spinner infinito).

### `lightning:formattedText`
- **Finalidade**: exibir texto respeitando quebras de linha e links.
- **Atributos principais**: `value`, `linkify`.
- **Exemplo**:
```html
<lightning:formattedText value="{!v.descricao}" linkify="true"/>
```
- **Quando usar**: exibir texto vindo de campos longos/rich text simples.
- **Erros comuns**: usar `<p>{!v.texto}</p>` normal quando precisa preservar quebras de linha.

### `lightning:formattedDateTime`
- **Finalidade**: formatar datas conforme locale do usuário.
- **Atributos principais**: `value`, `year`, `month`, `day`, `hour`, `minute`.
- **Exemplo**:
```html
<lightning:formattedDateTime value="{!v.dataCriacao}" year="numeric" month="short" day="2-digit"/>
```
- **Quando usar**: sempre que exibir data/hora ao usuário (evita formatação manual com JS).
- **Erros comuns**: passar string em formato inválido (deve ser ISO ou Date).

### `lightning:formattedNumber`
- **Finalidade**: formatar números/moeda/percentual.
- **Atributos principais**: `value`, `style` (`decimal`, `currency`, `percent`), `currencyCode`.
- **Exemplo**:
```html
<lightning:formattedNumber value="{!v.valor}" style="currency" currencyCode="BRL"/>
```
- **Quando usar**: exibir valores monetários/percentuais formatados corretamente.
- **Erros comuns**: esquecer `currencyCode` ao usar `style="currency"`.

### `lightning:recordForm`
- **Finalidade**: formulário automático (view/edit/create) baseado em metadata do objeto, sem Apex.
- **Atributos principais**: `recordId`, `objectApiName`, `fields`, `mode` (`view`, `edit`), `onsuccess`, `onerror`.
- **Exemplo**:
```html
<lightning:recordForm objectApiName="Aluno__c" fields="{!v.campos}" mode="edit" onsuccess="{!c.handleSuccess}"/>
```
- **Quando usar**: CRUD simples e rápido sem lógica de negócio customizada.
- **Erros comuns**: tentar customizar layout visual demais — `recordForm` é limitado para isso, o caso de uso é forms rápidos.

### `lightning:recordEditForm`
- **Finalidade**: formulário editável customizável, composto por `lightning:inputField`.
- **Atributos principais**: `recordId`, `objectApiName`, `onsuccess`, `onsubmit`, `onerror`.
- **Exemplo**:
```html
<lightning:recordEditForm objectApiName="Aluno__c" onsuccess="{!c.handleSuccess}">
    <lightning:messages/>
    <lightning:inputField fieldName="Name"/>
    <lightning:button type="submit" label="Salvar"/>
</lightning:recordEditForm>
```
- **Quando usar**: quando precisa de layout customizado mas ainda quer o CRUD automático sem Apex.
- **Erros comuns**: esquecer `<lightning:messages/>` (erros de validação não aparecem para o usuário).

### `lightning:recordViewForm`
- **Finalidade**: exibição somente leitura, composto por `lightning:outputField`.
- **Atributos principais**: `recordId`, `objectApiName`.
- **Exemplo**:
```html
<lightning:recordViewForm objectApiName="Aluno__c" recordId="{!v.recordId}">
    <lightning:outputField fieldName="Name"/>
</lightning:recordViewForm>
```
- **Quando usar**: telas de detalhe/visualização sem necessidade de edição.
- **Erros comuns**: usar quando na verdade precisa de edição (confundir com `recordEditForm`).

### `lightning:inputField`
- **Finalidade**: campo de edição vinculado a um campo real do objeto (dentro de `recordEditForm`).
- **Atributos principais**: `fieldName`.
- **Quando usar**: sempre dentro de `recordEditForm`, nunca isolado.
- **Erros comuns**: usar fora de um form de edição (não funciona sozinho).

### `lightning:outputField`
- **Finalidade**: exibição somente leitura de um campo (dentro de `recordViewForm`).
- **Atributos principais**: `fieldName`.
- **Erros comuns**: mesmo problema — precisa estar dentro do form correspondente.

### `lightning:layout` / `lightning:layoutItem`
- **Finalidade**: grid responsivo baseado no SLDS.
- **Atributos principais** (`layout`): `horizontalAlign`, `multipleRows`. (`layoutItem`): `size`, `smallDeviceSize`, `mediumDeviceSize`, `largeDeviceSize`, `padding`.
- **Exemplo**:
```html
<lightning:layout>
    <lightning:layoutItem size="6" padding="around-small">Coluna 1</lightning:layoutItem>
    <lightning:layoutItem size="6" padding="around-small">Coluna 2</lightning:layoutItem>
</lightning:layout>
```
- **Quando usar**: qualquer grid responsivo sem escrever CSS de grid manualmente.
- **Erros comuns**: esquecer que `size` é baseado em 12 colunas (SLDS grid), somar valores errados.

### `lightning:tabset` / `lightning:tab`
- **Finalidade**: navegação em abas.
- **Atributos principais** (`tabset`): `variant`, `selectedTabId`. (`tab`): `label`, `id`.
- **Exemplo**:
```html
<lightning:tabset>
    <lightning:tab label="Dados">Conteúdo A</lightning:tab>
    <lightning:tab label="Histórico">Conteúdo B</lightning:tab>
</lightning:tabset>
```
- **Quando usar**: organizar conteúdo denso em seções navegáveis.
- **Erros comuns**: colocar conteúdo pesado em todas as abas ao mesmo tempo (todas são renderizadas; considere lazy loading manual se necessário).

### `lightning:accordion` / `lightning:accordionSection`
- **Finalidade**: seções expansíveis/colapsáveis.
- **Atributos principais** (`accordion`): `activeSectionName`, `allowMultipleSectionsOpen`. (`accordionSection`): `label`, `name`.
- **Exemplo**:
```html
<lightning:accordion activeSectionName="A">
    <lightning:accordionSection name="A" label="Seção A">Conteúdo</lightning:accordionSection>
</lightning:accordion>
```
- **Quando usar**: informação secundária/opcional que não precisa estar sempre visível.
- **Erros comuns**: esquecer `name` único em cada seção (comportamento de abrir/fechar quebra).

---

## Capítulo 4 — Caso de uso e preparação do ambiente

### Caso de uso realista
**Cenário**: painel para a academia onde a recepção consulta alunos, vê status de mensalidade e registra presença.

**1. Compreender o problema**
Recepção perde tempo procurando manualmente se o aluno está em dia e não tem visão rápida da graduação/faixa.

**2. Levantar requisitos**
- Buscar aluno por nome.
- Exibir status da mensalidade (pago/pendente).
- Exibir faixa atual e data do último exame.
- Botão para registrar presença do dia.

**3. Identificar usuários**
Recepcionista (perfil com acesso de leitura/edição limitado) e instrutor (marca presença).

**4. Identificar objetos e campos**
- `Aluno__c`: `Name`, `Faixa__c`, `Data_Ultimo_Exame__c`.
- `Mensalidade__c`: `Aluno__c` (lookup), `Status__c`, `Data_Vencimento__c`.
- `Presenca__c`: `Aluno__c` (lookup), `Data__c`.

**5. Decidir componentes necessários**
- `lightning:input` (busca por nome).
- `lightning:card` (exibição do aluno).
- `lightning:formattedDateTime` (data do exame).
- `lightning:button` (registrar presença).
- `aura:iteration` (lista de resultados).
- `lightning:spinner` (carregamento).

**6. Criar o projeto**
```bash
sf project generate --name academia-app
```

**7. Autenticar a org**
```bash
sf org login web --alias academia --set-default
```

**8. Criar o componente**
```bash
sf project generate --type aura --name PainelAluno --output-dir force-app/main/default/aura
```

**9. Realizar deploy**
```bash
sf project deploy start --target-org academia --source-dir force-app/main/default/aura/PainelAluno --wait 30
```

**10. Testar**
Adicionar o componente em uma App Page (Lightning App Builder) e testar busca/presença manualmente.

**11. Corrigir erros**
Verificar log de erro do deploy (retorna detalhe de linha/coluna); revisar `Controller.js` se ação não disparar.

**12. Documentar a solução**
Registrar no `README.md` do projeto: objetos usados, componente criado, como testar.

---

## Capítulo 5 — Estrutura de um Aura Lightning Component

Estrutura de pastas típica:
```
aura/
  PainelAluno/
    PainelAluno.cmp
    PainelAlunoController.js
    PainelAlunoHelper.js
    PainelAluno.css
    PainelAluno.design
    PainelAluno.svg
    PainelAlunoRenderer.js   (opcional)
```

**`.cmp`** — arquivo principal, define o markup (HTML-like) e os atributos (`aura:attribute`). É o "template" do componente.

**`Controller.js`** — recebe eventos disparados pelo markup (`onclick`, `onchange`, `init`). Deve ser fino: só repassa a chamada para o Helper. Não deve conter lógica de negócio complexa.
```js
({
    handleSave : function(component, event, helper) {
        helper.saveAluno(component);
    }
})
```

**`Helper.js`** — contém a lógica reutilizável (chamadas Apex, manipulação de dados, formatação). Pode ser chamado tanto pelo Controller quanto por si mesmo.
```js
({
    saveAluno : function(component) {
        var action = component.get("c.salvarAluno");
        action.setParams({ aluno: component.get("v.aluno") });
        action.setCallback(this, function(response) {
            // trata resposta
        });
        $A.enqueueAction(action);
    }
})
```

**`.css`** — estilos específicos do componente. O escopo é automaticamente restrito ao componente, então não vaza para outros componentes.

**`.design`** — usado quando o componente será configurável no App Builder (Lightning App Builder / Community Builder). Define quais atributos aparecem como propriedades editáveis.
```xml
<design:component>
    <design:attribute name="titulo" label="Título do Card"/>
</design:component>
```

**`.svg`** — ícone customizado do componente, exibido no App Builder ao arrastar o componente para a página.

**`Renderer.js`** — usado apenas quando é preciso interceptar o ciclo de vida de renderização do DOM (raro).
```js
({
    afterRender: function(component, helper) {
        this.superAfterRender();
        // lógica pós-renderização
    }
})
```

**Relacionamento entre os arquivos:** `.cmp` referencia funções do Controller (`c.nomeFuncao`) → Controller chama Helper → Helper chama Apex/manipula atributos (`component.set`) → mudança de atributo dispara re-render do `.cmp`.

**Ciclo de vida:** `init` (evento `aura:doInit`) → renderização inicial → interações do usuário disparam eventos → Controller → Helper → atualização de atributo → re-render.

**Organização recomendada:** Controller só delega; Helper concentra toda a lógica; nomes de função consistentes entre Controller e Helper.

---

## Capítulo 6 — Conceito de `@AuraEnabled`

**O que é:** anotação Apex que expõe um método (ou propriedade) para ser chamado a partir de componentes Aura (e LWC).

**Onde pode ser usado:** métodos `public` ou `global`, estáticos ou de instância, dentro de classes Apex. Também em propriedades de classes wrapper para serializar dados customizados.

**Como expor métodos Apex para Aura:**
```java
public with sharing class AlunoService {
    @AuraEnabled(cacheable=true)
    public static List<Aluno__c> buscarAlunos(String nome) {
        return [SELECT Id, Name, Faixa__c FROM Aluno__c WHERE Name LIKE :('%' + nome + '%') LIMIT 50];
    }
}
```

- **Parâmetros**: tipos primitivos, sObjects, listas, e classes wrapper (desde que serializáveis em JSON).
- **Retorno**: mesmas regras — deve ser serializável.
- **`cacheable=true`**: só permitido em métodos que apenas leem dados (sem DML); permite cache no client e `refreshApex`.
- **Métodos estáticos vs instância**: Aura chama ambos da mesma forma via `c.nomeMetodo`.

**Tratamento de exceções:**
```java
@AuraEnabled
public static void salvarAluno(Aluno__c aluno) {
    try {
        upsert aluno;
    } catch (DMLException e) {
        throw new AuraHandledException(e.getMessage());
    }
}
```
`AuraHandledException` é a forma correta de propagar erro tratado para o front-end.

**Diferenças entre método `@AuraEnabled` e método Apex comum:** método comum não pode ser chamado do front-end, mesmo sendo `public static`. `@AuraEnabled` passa por serialização JSON automática.

**Cuidados com permissões:** `with sharing` respeita regras de compartilhamento; ainda assim, CRUD/FLS não são aplicados automaticamente — verificar manualmente ou usar `WITH SECURITY_ENFORCED` na SOQL.

**Riscos de exposição de dados:** retornar campos sensíveis sem necessidade; não validar FLS/CRUD; query sem `LIMIT`.

**Boas práticas:** sempre usar `with sharing`; validar CRUD/FLS; usar `AuraHandledException`; usar `cacheable=true` só em leitura pura; limitar volume de dados.

**Exemplo completo:**

Apex:
```java
public with sharing class AlunoService {
    @AuraEnabled(cacheable=true)
    public static List<Aluno__c> buscarAlunos(String nome) {
        return [SELECT Id, Name, Faixa__c FROM Aluno__c WHERE Name LIKE :('%' + nome + '%') LIMIT 50];
    }
}
```

Aura Component (chamada):
```js
({
    buscar : function(component) {
        var action = component.get("c.buscarAlunos");
        action.setParams({ nome: component.get("v.termoBusca") });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.alunos", response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error(errors[0].message);
            }
        });
        $A.enqueueAction(action);
    }
})
```

---

## Capítulo 7 — Aura Component Attributes

**O que são atributos:** variáveis declaradas no `.cmp` que armazenam o estado do componente, acessíveis via `v.nomeAtributo`.

**Declaração:**
```xml
<aura:attribute name="nomeAluno" type="String" default=""/>
```

**Tipos:**
- Simples: `String`, `Integer`, `Boolean`, `Date`, `Decimal`.
- Lista: `List` (ex: lista de sObjects ou wrapper).
- Objeto: `Object` (genérico) ou tipo sObject (`Aluno__c`).

**Valores padrão:**
```xml
<aura:attribute name="carregando" type="Boolean" default="false"/>
```

**Atributos de lista:**
```xml
<aura:attribute name="alunos" type="Aluno__c[]"/>
```

**Atributos de objeto:**
```xml
<aura:attribute name="alunoSelecionado" type="Aluno__c"/>
```

**Atributos para controle de estado:** booleanos (`carregando`, `temErro`, `mostrarModal`) para controlar exibição condicional (`aura:if`).

**Acesso com `v`** (View/estado do componente):
```js
var nome = component.get("v.nomeAluno");
component.set("v.nomeAluno", "Novo valor");
```

**Acesso com `c`** (Controller/ações Apex):
```js
var action = component.get("c.buscarAlunos");
```

**Ligação de valores (binding):**
```html
<lightning:input value="{!v.nomeAluno}"/>
```
Two-way binding: alteração no input atualiza `v.nomeAluno` automaticamente.

**Passagem de dados** entre pai e filho:
```html
<c:CardAluno aluno="{!v.alunoSelecionado}"/>
```

**Atualização de atributos:** sempre via `component.set("v.atributo", valor)` — nunca manipular diretamente sem re-setar, pois o Aura precisa detectar a mudança para re-renderizar.

**Exercício prático:** criar um atributo `contador` (Integer, default 0) e um botão que incrementa +1 a cada clique, exibindo o valor com `{!v.contador}`.

---

## Capítulo 8 — Aura Markup e CSS

**Estrutura do markup:**
```html
<aura:component controller="AlunoService">
    <aura:attribute name="alunos" type="Aluno__c[]"/>
    <lightning:card title="Alunos">
        <!-- conteúdo -->
    </lightning:card>
</aura:component>
```

**Componentes aninhados:**
```html
<c:CardAluno aluno="{!v.alunoSelecionado}"/>
```

**Expressões:**
```html
<p>{!v.aluno.Name}</p>
<aura:if isTrue="{!v.carregando}">Carregando...</aura:if>
```

**Manipulação de atributos:** via `component.set`/`component.get` no JS, refletido automaticamente no markup.

**Eventos no markup:**
```html
<lightning:button onclick="{!c.handleClick}"/>
```

**Classes SLDS:**
```html
<div class="slds-grid slds-wrap slds-p-around_medium">
```

**CSS específico:**
```css
.THIS .destaque {
    border-left: 4px solid #0070d2;
}
```
`.THIS` é o seletor especial do Aura que aplica o escopo ao componente.

**Escopo do CSS:** cada componente tem seu CSS isolado automaticamente — não há vazamento entre componentes.

**Organização visual:** combine `lightning:layout`/`layoutItem` para grid + classes SLDS de espaçamento (`slds-p-*`, `slds-m-*`).

**Responsividade:** use `smallDeviceSize`, `mediumDeviceSize`, `largeDeviceSize` no `lightning:layoutItem`.

**Acessibilidade:** sempre incluir `alternativeText` em ícones/spinners, `label` em inputs, e usar elementos semânticos.

**Exemplo — cartão com formulário, botão e mensagem:**
```html
<aura:component controller="AlunoService">
    <aura:attribute name="nome" type="String"/>
    <aura:attribute name="mensagem" type="String"/>

    <lightning:card title="Cadastro de Aluno" iconName="standard:contact">
        <div class="slds-p-around_medium">
            <lightning:input label="Nome" value="{!v.nome}"/>
            <lightning:button label="Salvar" variant="brand" class="slds-m-top_small" onclick="{!c.handleSave}"/>
            <aura:if isTrue="{!v.mensagem}">
                <p class="slds-text-color_success slds-m-top_small">{!v.mensagem}</p>
            </aura:if>
        </div>
    </lightning:card>
</aura:component>
```

---

## Capítulo 9 — Aura Iteration

**O que é `aura:iteration`:** componente para renderizar listas dinamicamente no markup, semelhante a um `for` no template.

**Como percorrer uma lista:**
```html
<aura:iteration items="{!v.alunos}" var="aluno" indexVar="idx">
    <p>{!idx}: {!aluno.Name}</p>
</aura:iteration>
```

**Índice:** `indexVar="idx"` expõe a posição do item na lista.

**Item atual:** `var="aluno"` expõe o item corrente do array.

**Exibição de dados:**
```html
<aura:iteration items="{!v.alunos}" var="aluno">
    <div class="slds-box slds-m-bottom_small">
        <p>{!aluno.Name} — {!aluno.Faixa__c}</p>
    </div>
</aura:iteration>
```

**Seleção de item / ação sobre um item:**
```html
<lightning:button label="Selecionar" data-id="{!aluno.Id}" onclick="{!c.handleSelect}"/>
```
```js
handleSelect : function(component, event, helper) {
    var id = event.target.dataset.id;
    helper.selecionarAluno(component, id);
}
```

**Listas retornadas pelo Apex:**
```java
@AuraEnabled(cacheable=true)
public static List<Aluno__c> listarAlunos() {
    return [SELECT Id, Name, Faixa__c FROM Aluno__c LIMIT 100];
}
```

**Tratamento de lista vazia:**
```html
<aura:if isTrue="{!v.alunos.length == 0}">
    <p>Nenhum aluno encontrado.</p>
</aura:if>
```
Atenção: para listas nulas é mais seguro verificar no Helper antes de setar o atributo.

**Desempenho em listas grandes:**
- Sempre limitar a query (`LIMIT`) e considerar paginação.
- Evitar lógica pesada dentro do próprio markup da iteração (mover cálculos para o Helper).
- Preferir paginação client-side para listas muito grandes com atualizações frequentes.

---

## Capítulo 10 — Controller, Helper e chamada Apex

**Responsabilidade do Controller:** recebe o evento do markup e delega ao Helper. Não deve conter lógica de negócio.

**Responsabilidade do Helper:** concentra a lógica: monta a chamada Apex, trata callback, atualiza atributos, trata erros.

**Responsabilidade do Apex:** executa a regra de negócio real (consulta, gravação, validação) e retorna dados serializáveis.

**Diferença entre Controller e Helper:** Controller = "o que aconteceu" (evento). Helper = "o que fazer" (lógica). Helper também pode ser chamado por outro Helper, enquanto Controller só é chamado pelo markup.

**Organização das funções:** nomeie de forma correspondente: `handleBuscar` (Controller) → `buscarAlunos` (Helper).

**Passagem de eventos:** eventos do DOM (`onclick`, `onchange`) chamam funções do Controller, que recebem `(component, event, helper)`.

**Criação de ações Apex:**
```js
var action = component.get("c.buscarAlunos");
action.setParams({ nome: termo });
```

**`setCallback`:**
```js
action.setCallback(this, function(response) {
    var state = response.getState();
    if (state === "SUCCESS") {
        component.set("v.alunos", response.getReturnValue());
    } else if (state === "ERROR") {
        var errors = response.getError();
        component.set("v.mensagemErro", errors[0].message);
    }
    component.set("v.carregando", false);
});
```

**Estados de sucesso / erro / carregamento:**
```js
buscarAlunos : function(component) {
    component.set("v.carregando", true);
    var action = component.get("c.buscarAlunos");
    action.setParams({ nome: component.get("v.termoBusca") });
    action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {
            component.set("v.alunos", response.getReturnValue());
            component.set("v.mensagemErro", null);
        } else if (state === "ERROR") {
            var errors = response.getError();
            component.set("v.mensagemErro", errors[0].message);
        }
        component.set("v.carregando", false);
    });
    $A.enqueueAction(action);
}
```

**Tratamento de exceções:** no Apex, lançar `AuraHandledException` com mensagem clara; no Helper, sempre checar `state === "ERROR"` e extrair `response.getError()[0].message`.

**Fluxo completo:**
```
.cmp (markup) --onclick--> Controller.js --delega--> Helper.js
Helper.js --chama ação--> Classe Apex (@AuraEnabled)
Classe Apex --retorna response (SUCCESS/ERROR)--> Helper.js
Helper.js --component.set("v.alunos", dados)--> .cmp (re-render)
```
