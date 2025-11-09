# Documento de Design

Por Carter Zenke

Visão geral do vídeo: (Normalmente, haveria um URL aqui, mas não para esta amostra de trabalho!)

## Âmbito

A base de dados inclui todas as entidades necessárias para facilitar o processo de acompanhamento do progresso dos alunos e deixar feedback sobre os trabalhos. Como tal, incluído no âmbito da base de dados está:

-   Alunos, incluindo informações básicas de identificação
-   Instrutores, incluindo informações básicas de identificação
-   Submissões dos alunos, incluindo a hora em que a submissão foi feita, a pontuação de correção que recebeu e o problema ao qual a submissão está relacionada
-   Problemas, que incluem informações básicas sobre os problemas do curso
-   Comentários de instrutores, incluindo o conteúdo do comentário e a submissão em que o comentário foi deixado

Estão fora do âmbito elementos como certificados, notas finais e outros atributos não centrais.

## Requisitos Funcionais

Esta base de dados irá suportar:

-   Operações CRUD para alunos e instrutores
-   Rastreamento de todas as versões das submissões dos alunos, incluindo múltiplas submissões para o mesmo problema
-   Adicionar múltiplos comentários a uma submissão de aluno por parte de instrutores

Note-se que, nesta iteração, o sistema não suportará a resposta de alunos a comentários.

## Representação

As entidades são capturadas em tabelas SQLite com o seguinte schema.

### Entidades

A base de dados inclui as seguintes entidades:

#### Students

A tabela `students` inclui:

-   `id`, que especifica o ID único para o aluno como um `INTEGER`. Esta coluna tem, assim, a constraint `PRIMARY KEY` aplicada.
-   `first_name`, que especifica o primeiro nome do aluno como `TEXT`, dado que `TEXT` é apropriado para campos de nome.
-   `last_name`, que especifica o último nome do aluno. `TEXT` é usado pela mesma razão que `first_name`.
-   `github_username`, que especifica o username GitHub do aluno. `TEXT` é usado pela mesma razão que `first_name`. Uma constraint `UNIQUE` garante que não há dois alunos com o mesmo username GitHub.
-   `started`, que especifica quando o aluno começou o curso. Timestamps em SQLite podem ser convenientemente armazenados como `NUMERIC`, de acordo com a documentação do SQLite em <https://www.sqlite.org/datatype3.html>. O valor por defeito para o atributo `started` é o timestamp atual, conforme indicado por `DEFAULT CURRENT_TIMESTAMP`.

#### Instructors

A tabela `instructors` inclui:

-   `id`, que especifica o ID único para o instrutor como um `INTEGER`. Esta coluna tem, assim, a constraint `PRIMARY KEY` aplicada.
-   `first_name`, que especifica o primeiro nome do instrutor como `TEXT`.
-   `last_name`, que especifica o último nome do instrutor como `TEXT`.

Todas as colunas na tabela `instructors` são obrigatórias e, portanto, devem ter a constraint `NOT NULL` aplicada. Não são necessárias outras constraints.

#### Problems

A tabela `problems` inclui:

-   `id`, que especifica o ID único para o instrutor como um `INTEGER`. Esta coluna tem, assim, a constraint `PRIMARY KEY` aplicada.
-   `problem_set`, que é um `INTEGER` que especifica o número do conjunto de problemas do qual o problema faz parte. Os conjuntos de problemas _não_ são representados separadamente, dado que cada um é apenas identificado por um número.
-   `name`, que é o nome do conjunto de problemas como `TEXT`.

Todas as colunas na tabela `problems` são obrigatórias e, portanto, devem ter a constraint `NOT NULL` aplicada. Não são necessárias outras constraints.

#### Submissions

A tabela `submissions` inclui:

-   `id`, que especifica o ID único para a submissão como um `INTEGER`. Esta coluna tem, assim, a constraint `PRIMARY KEY` aplicada.
-   `student_id`, que é o ID do aluno que fez a submissão como um `INTEGER`. Esta coluna tem, assim, a constraint `FOREIGN KEY` aplicada, referenciando a coluna `id` na tabela `students` para garantir a integridade dos dados.
-   `problem_id`, que é o ID do problema que a submissão resolve como um `INTEGER`. Esta coluna tem, assim, a constraint `FOREIGN KEY` aplicada, referenciando a coluna `id` na tabela `problems` para garantir a integridade dos dados.
-   `submission_path`, que é o caminho, relativo à base de dados, onde os ficheiros de submissão são armazenados. Presume-se que todas as submissões são carregadas para o mesmo servidor onde o ficheiro da base de dados está armazenado, e que os ficheiros de submissão podem ser acedidos seguindo o caminho relativo a partir da base de dados. Dado que este atributo armazena um filepath, e não os próprios ficheiros de submissão, é do tipo de afinidade `TEXT`.
-   `correctness`, que é a pontuação, como um float de 0 a 1.0, que o aluno recebeu na atribuição. Esta coluna é representada com uma afinidade de tipo `NUMERIC`, que pode armazenar floats ou inteiros.
-   `timestamp`, que é o timestamp em que a submissão foi feita.

Todas as colunas são obrigatórias e, portanto, têm a constraint `NOT NULL` aplicada onde uma constraint `PRIMARY KEY` ou `FOREIGN KEY` não está presente. A coluna `correctness` tem uma constraint adicional para verificar se o seu valor é maior que 0 e menor ou igual a 1, dado que este é o intervalo válido para uma pontuação de correção. Semelhante ao atributo `started` do aluno, o atributo `timestamp` da submissão tem como valor por defeito o timestamp atual quando uma nova linha é inserida.

#### Comments

A tabela `comments` inclui:

-   `id`, que especifica o ID único para a submissão como um `INTEGER`. Esta coluna tem, assim, a constraint `PRIMARY KEY` aplicada.
-   `instructor_id`, que especifica o ID do instrutor que escreveu o comentário como um `INTEGER`. Esta coluna tem, assim, a constraint `FOREIGN KEY` aplicada, referenciando a coluna `id` na tabela `instructors`, o que garante que cada comentário seja referenciado de volta a um instrutor.
-   `submission_id`, que especifica o ID da submissão sobre a qual o comentário foi escrito como um `INTEGER`. Esta coluna tem, assim, a constraint `FOREIGN KEY` aplicada, referenciando a coluna `id` na tabela `submissions`, o que garante que cada comentário pertença a uma submissão específica.
-   `contents`, que contém o conteúdo das colunas como `TEXT`, dado que `TEXT` pode ainda armazenar texto de formato longo.

Todas as colunas são obrigatórias e, portanto, têm a constraint `NOT NULL` aplicada onde uma constraint `PRIMARY KEY` ou `FOREIGN KEY` não está presente.

### Relacionamentos

O diagrama de relacionamento de entidades abaixo descreve os relacionamentos entre as entidades na base de dados.

![ER Diagram](diagram.png)

Conforme detalhado no diagrama:

-   Um aluno é capaz de fazer de 0 a muitas submissões. 0, se ainda não submeteu nenhum trabalho, e muitas se submeter a mais de um problema (ou fizer mais de uma submissão para qualquer problema). Uma submissão é feita por um e apenas um aluno. Presume-se que os alunos submeterão trabalho individual (não trabalho em grupo).
-   Uma submissão está associada a um e apenas um problema. Ao mesmo tempo, um problema pode ter de 0 a muitas submissões: 0 se nenhum aluno ainda submeteu trabalho para esse problema, e muitas se mais de um aluno submeteu trabalho para esse problema.
-   Um comentário está associado a uma e apenas uma submissão, enquanto uma submissão pode ter de 0 a muitos comentários: 0 se um instrutor ainda não comentou a submissão, e muitos se um instrutor deixar mais de um comentário numa submissão.
-   Um comentário é escrito por um e apenas um instrutor. Ao mesmo tempo, um instrutor pode escrever de 0 a muitos comentários: 0 se ainda não comentou nenhum trabalho de aluno, e muitos se tiver escrito mais de 1 comentário.

## Otimizações

De acordo com as queries típicas em `queries.sql`, é comum para os utilizadores da base de dados aceder a todas as submissões feitas por qualquer aluno em particular. Por essa razão, são criados indexes nas colunas `first_name`, `last_name` e `github_username` para acelerar a identificação de alunos por essas colunas.

É também prática comum para um utilizador da base de dados estar preocupado em visualizar todos os alunos que submeteram trabalho para um problema em particular. Como tal, um index é criado na coluna `name` na tabela `problems` para acelerar a identificação de problemas por nome.

## Limitações

O schema atual assume submissões individuais. Submissões colaborativas exigiriam uma mudança para um relacionamento many-to-many entre alunos e submissões.
