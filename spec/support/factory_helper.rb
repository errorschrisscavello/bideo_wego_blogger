module FactoryHelper
  TEXT_BODIES = [
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aperiam cupiditate quibusdam nulla nobis, recusandae velit, commodi non amet delectus saepe doloribus cum ratione est excepturi porro a consectetur aliquam iste!',
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nam in quas facilis possimus deleniti blanditiis mollitia et quam nisi, maiores labore est. Nemo ducimus non, velit explicabo libero maiores facilis!',
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloribus omnis maxime ducimus officiis magni quas dolore odio minus harum iusto, cumque dolorum mollitia sequi, facere voluptatem temporibus laboriosam placeat non?',
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reprehenderit laboriosam, atque. Esse non fuga laudantium iure quo sint inventore mollitia provident nisi beatae quod atque, voluptatum, hic maxime maiores sunt.',
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium provident repudiandae qui harum, corporis repellendus illo impedit voluptatum rem nulla quae est aspernatur minus quam nesciunt doloremque fuga sequi culpa.',
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eveniet accusamus, veritatis fuga id nam corrupti quis quos inventore, perspiciatis ab! Fugiat animi, qui doloribus aut quas enim dignissimos libero dolorum?'
  ]

  FIRST_NAMES = [
    'Moe',
    'Larry',
    'Curly',
    'Elmer',
    'Mickey',
    'Daffy',
    'Bugs',
    'Porky',
    'Minnie',
    'Tom',
    'Jerry'
  ]
  LAST_NAMES = [
    'Fud',
    'Mouse',
    'Duck',
    'Bunny',
    'Pig',
    'Cat'
  ]


  def self.first_name(n=0)
    FIRST_NAMES[n % FIRST_NAMES.length]
  end

  def self.last_name(n=0)
    LAST_NAMES[n % LAST_NAMES.length]
  end

  def self.email(n=0)
    "#{first_name(n).downcase}-#{n}@#{last_name(n).downcase}.com"
  end

  def self.username(n=0)
    "#{first_name(n).downcase}_#{last_name(n).downcase}#{n}"
  end

  def self.text(n=0)
    TEXT_BODIES[n % TEXT_BODIES.length]
  end
end



