module DatabaseCleanerConfig
  def self.setup(config)
    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.around do |example|
      DatabaseCleaner.cleaning { example.run }
    end
  end
end
