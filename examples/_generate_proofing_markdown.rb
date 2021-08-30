# generate markdown from each example in this dir, based on svgs present
# paste it in to EXAMPLES.md

working_dir = ENV['WORKING_DIR'] || '.'

output_file = ARGV[0]

require 'fileutils'

# rename existing SVGs
Dir.glob("#{working_dir}/*.svg").sort.each do |svg_fn|
  next if svg_fn =~ /\.old\./

  old_fn = [
    working_dir,
    '/',
    svg_fn.split('.')[0..-2],
    '.old.svg'
  ].join
  # puts "#{svg_fn.inspect} -> #{old_fn.inspect}"
  FileUtils.cp(svg_fn, old_fn)
end

# generate new SVGs
Dir.glob("#{working_dir}/*.rb").sort.each do |rb_fn|
  next if rb_fn =~ /^#{working_dir}\/_/

  puts "--- #{rb_fn.inspect} ---"
  puts `bundle exec ruby #{rb_fn}`
end

versions = {}

Dir.glob("#{working_dir}/*.svg").sort.each do |svg_fn|
  country_name = svg_fn.match(/^(.+?)\./)[1]
  versions[country_name] ||= {}

  if svg_fn =~ /\.old\./
    versions[country_name][:old] = svg_fn
  else
    versions[country_name][:new] = svg_fn
  end
end

output = []

versions.keys.sort.each do |key|
  country_output = []
  country_output << "### #{key}\n"
  country_output << "![new version of flag for #{key}](#{versions[key][:new].split('/').last})"
  country_output << "![old version of flag for #{key}](#{versions[key][:old].split('/').last})"

  output << country_output.join("\n")
end

if output_file
  File.new(output_file, 'w').write(output.join("\n"))
else
  puts output.join("\n")
end
