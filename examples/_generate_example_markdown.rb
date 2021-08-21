# generate markdown from each example in this dir, based on svgs present
# paste it in to EXAMPLES.md

working_dir = (ARGV[0] || '.').sub(/\/$/, '')

output = []

Dir.glob("#{working_dir}/*.svg").sort.each do |svg_fn|
  country_name = svg_fn.split('.')[-2].split(/\/+/).last

  example_fn = "#{working_dir}/#{country_name}.rb"
  next if !File.exist?(example_fn)

  pretty_country_name = if (match = File.open(example_fn).read.match(/Vexillogram.new\(['"](.+?)['"]/))
    match[1]
  else
    country_name
  end

  country_output = []

  country_output << "### [#{pretty_country_name}](#{example_fn.split('/').last})\n"
  country_output << "[![Rendered Flag of #{pretty_country_name}](#{svg_fn.split('/').last})](#{example_fn.split('/').last})\n"

  output << country_output.join("\n")
end

puts "# Vexillogram Examples\n\n"

puts output.join("\n-----\n")
