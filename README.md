##Et si quelqu'un venait de la part de Cassandre, Ouvre-lui tôt la porte et ne le fais pas attendre

##PoissonRB @ EPITA
###1er Avril 2014 
####Ori Pekelman

* * * 
Salve communitas Lutetianae Rubiniensis.

* * *
 Cassandrae sumus loqui.

* * * 
  Prima aprilis est ergo Latine loqui vobis volui neque ex sermone Gallico vetero sed aeger sum non bene valeo et munus est difficile. 

* * *
  Ce seroit a ma grant honte que reste du conte en françois se feroit.

* * *
###CAVEAT
![Alt text](Running_with_Scissors_by_Luneth101.jpg)

* * *
###CAVEAT 
##Postgres fera l'affaire dans 99% des cas d'usage que vous avez.

Voilà c'est dit (et c'est le denier mot en latin pour aujourd'hui)

* * *

* Cassandra est une base de données orientée colonnes. De la famille Dynamo.
* Elle est par nature distribuée. 
* Elle peut supporter des charges en écriture inimaginable avec une technologie relationnelle. Elle peut monter à des tailles très conséquentes.
* Il y a encore peu de temps elle était très difficile à maîtriser et à mettre en production

* * *

Notez quand même BigQuery & Redshift mais on n'aime pas le cloud nous si?

* * * 
* Aujourd'hui ça devient presque trop facile
* Il y a beaucoup d'outils autour
* Et on a d'excellentes Gems en Ruby
* Quand vous prévoyez à court terme plus qu'un GO de nouvelles écritures par jour vous pouvez commencer à le considérer.

* * *
```sh
apt-get install dsc20
apt-get install opscenter
apt-get install datastax-agent
```
Il y a des outils en ligne de commande il y a des outils fenêtrés

* * *
## Son domaine de prédilection c'est les timeseries
### Comme dans le "internet of things" 

![Smokio](456973489_640.jpg)

### ... à titre d'exemple Smokio présents ce soir
* * *
```sh
rails new paris-rb-cassandra
cd paris-rb-cassandra
```

* * *

```sh
$EDITOR Gemfile
```

```ruby
    gem 'cequel'
```

* * *
## add dev gems cause we can't live without them

```ruby
group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'byebug'
end
```

* * *
```sh
bundle
```
```ruby
rails g cequel:configuration

rails g cequel person name:text
rails g scaffold person name:text

rails g cequel heart_beat heart_beat:timestamp intensity:int
rails g scaffold heart_beat heart_beat:timestamp intensity:int
```

* * *
```sh
$EDITOR app/models/heart_beat.rb
```
```ruby
  belongs_to :person
```
```sh
$EDITOR app/models/person.rb
```
```ruby
  has_many :heart_beats
```

* * *
```sh
rake cequel:init
```
```sh
$EDITOR app/controllers/heart_beats_controller.rb
```
>SO.... we had a problem with the datetime_select helper .. and no time to investigate. Hackety hack... you will see some more changes in the git ...

```ruby
def new
  raise "How can we have a hear beat withtout a person ?" if Person.count == 0
  @heart_beat = HeartBeat.new
  @heart_beat.person = Person.first 
end
```

* * *
```sh
$EDITOR app/concerns/cequel_concern.rb
```
```ruby
module CequelConcern
    extend ActiveSupport::Concern
    def read_attribute_for_serialization(n)
      n == "id" ? attributes[n].to_s : attributes[n]
    end
    
    def to_param
      self.id.to_s
    end
end
```
```sh
$EDITOR app/models/heart_beat.rb
```
```ruby
  include CequelConcern
```
```sh
$EDITOR app/models/person.rb
```
```ruby
  include CequelConcern
```

* * *
# This is too ugly
```sh
rails g layout:install
rails s
```

* * *
## La fin http://localhost:3000