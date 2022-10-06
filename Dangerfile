# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = github.pr_title.include? "#trivial"
# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("This Pull Request is quite big, more than 500 lines of changes.") if git.lines_of_code > 500

# SwiftFormat
swiftformat.binary_path = './Pods/SwiftFormat/CommandLineTool/swiftformat'
swiftformat.exclude = %w(Pods/**  **/*generated.swift)
swiftformat.check_format

# XCODE SUMMARY
xcode_summary.ignored_files = 'Pods/**'
xcode_summary.inline_mode = true
xcode_summary.report './result/WeatherTestResult.xcresult'

# Swiftlint
swiftlint.binary_path = './Pods/SwiftLint/swiftlint'
swiftlint.config_file = '.swiftlint.yml'
swiftlint.max_num_violations = 20
swiftlint.lint_all_files = true
swiftlint.lint_files(
  inline_mode: true,
  fail_on_error: false,
  additional_swiftlint_args: '--strict'
)

# XCOV
xcov.report(
    scheme: 'WeatherToday',
    workspace: 'WeatherToday.xcworkspace',
    exclude_targets: 'WeatherToday',
    minimum_coverage_percentage: 10.0,
    output_directory: 'xcov_report',
    markdown_report: true,
    html_report: false,
    derived_data_path: '.output'
)

# Post details XCOV report
isLineIncluded = false
message = "## Coverage Table\n\n"
File.open("./xcov_report/report.md", "r") do |f|
    f.each_line do |line|
      if line.include? "Files changed"
        isLineIncluded = true
      end
      if line.include? "Powered by"
        isLineIncluded = false
      end
      if isLineIncluded == true
        message << line
      end
    end
end
markdown message
