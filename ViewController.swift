import UIKit

class ViewController: UIViewController {
    
    var textField: UITextField!
    var searchButton: UIButton!
    var nameLabel: UILabel!
    var idLabel: UILabel!
    var heightLabel: UILabel!
    var weightLabel: UILabel!
    var typeLabel: UILabel!
    var pokemonImageView: UIImageView!
    var activityIndicator: UIActivityIndicatorView!
    
    let pokemonService = PokemonService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up UI elements
        setupUI()
    }
    
    // Setup UI elements
    func setupUI() {
        // Text Field
        textField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        textField.placeholder = "Digite o nome ou ID do Pokémon"
        textField.borderStyle = .roundedRect
        self.view.addSubview(textField)
        
        // Search Button
        searchButton = UIButton(frame: CGRect(x: 120, y: 150, width: 150, height: 50))
        searchButton.setTitle("Buscar Pokémon", for: .normal)
        searchButton.backgroundColor = .blue
        searchButton.layer.cornerRadius = 10
        searchButton.addTarget(self, action: #selector(fetchPokemonData), for: .touchUpInside)
        self.view.addSubview(searchButton)
        
        // Labels
        nameLabel = UILabel(frame: CGRect(x: 20, y: 200, width: 300, height: 20))
        self.view.addSubview(nameLabel)
        
        idLabel = UILabel(frame: CGRect(x: 20, y: 230, width: 300, height: 20))
        self.view.addSubview(idLabel)
        
        heightLabel = UILabel(frame: CGRect(x: 20, y: 260, width: 300, height: 20))
        self.view.addSubview(heightLabel)
        
        weightLabel = UILabel(frame: CGRect(x: 20, y: 290, width: 300, height: 20))
        self.view.addSubview(weightLabel)
        
        typeLabel = UILabel(frame: CGRect(x: 20, y: 320, width: 300, height: 20))
        self.view.addSubview(typeLabel)
        
        // Pokémon Image
        pokemonImageView = UIImageView(frame: CGRect(x: 100, y: 350, width: 150, height: 150))
        self.view.addSubview(pokemonImageView)
        
        // Activity Indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
    }
    
    @objc func fetchPokemonData() {
        guard let pokemonName = textField.text, !pokemonName.isEmpty else {
            // Show error if text field is empty
            displayError(message: "Por favor, insira o nome ou ID do Pokémon.")
            return
        }
        
        // Start loading
        activityIndicator.startAnimating()
        
        // Chama o serviço para buscar o Pokémon
        pokemonService.fetchPokemon(by: pokemonName) { result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            switch result {
            case .success(let pokemon):
                self.updateUI(with: pokemon)
            case .failure(let error):
                self.displayError(message: error.localizedDescription)
            }
        }
    }
    
    func updateUI(with pokemon: Pokemon) {
        nameLabel.text = "Nome: \(pokemon.name.capitalized)"
        idLabel.text = "ID: \(pokemon.id)"
        heightLabel.text = "Altura: \(pokemon.height) decímetros"
        weightLabel.text = "Peso: \(pokemon.weight) hectogramas"
        
        // Get types
        typeLabel.text = "Tipos: \(pokemon.types.joined(separator: ", "))"
        
        // Load image
        if let imageUrl = URL(string: pokemon.imageUrl), let imageData = try? Data(contentsOf: imageUrl) {
            pokemonImageView.image = UIImage(data: imageData)
        }
    }
    
    func displayError(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
