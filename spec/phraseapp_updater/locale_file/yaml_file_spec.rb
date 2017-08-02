require 'spec_helper'
require 'phraseapp_updater/locale_file/yaml_file'

describe PhraseAppUpdater::LocaleFile::YAMLFile do
  let(:locale_file) { PhraseAppUpdater::LocaleFile::YAMLFile.new(@name, @content) }
  before do
    @name    = 'ja'
    @content = "a: foo\nb: bar\n"
  end

  it 'returns its name' do
    expect(locale_file.name).to eq @name
  end

  it 'returns its name with an extension' do
    expect(locale_file.name_with_extension).to eq "#{@name}.yml"
  end

  it 'parses proper YAML' do
    @content = "---\na:\n  b: 5\n"
    expect(locale_file.parsed_content).to eq({"a" => {"b" => 5}})
  end

  it 'exposes its content' do
    expect(locale_file.content).to eq "a: foo\nb: bar\n"
  end

  it 'returns an error when passed bad YAML' do
    @content = '{"a39383\dasd;##*&#$'
    expect { locale_file }.to raise_error(ArgumentError)
  end

  it 'returns a string representation' do
    expect(locale_file.to_s).to eq "ja, a: foo\nb: bar\n..."
  end

  it 'can be initialized from a hash' do
    file = PhraseAppUpdater::LocaleFile::YAMLFile.from_hash('en', {"a" => 5})
    expect(file.content).to eq "---\na: 5\n"
    expect(file.parsed_content).to eq({"a" => 5})
  end
end
