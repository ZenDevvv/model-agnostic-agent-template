[CmdletBinding()]
param()

$required = @(
    '.project-truth/truth/project-truth.md'
    '.project-truth/truth/project-truth-summary.md'
    '.project-truth/truth/terminology.md'
    '.project-truth/truth/requirements.md'
    '.project-truth/truth/architecture.md'
    '.project-truth/truth/design.md'
    '.project-truth/workspace/context.md'
    '.project-truth/workspace/current-task.md'
    '.project-truth/governance/drift-guard.md'
)

foreach ($file in $required) {
    if (-not (Test-Path -LiteralPath $file) -or (Get-Item -LiteralPath $file).Length -eq 0) {
        throw "Missing or empty project-truth file: $file"
    }
}

$files = Get-ChildItem -Recurse -File -Path AGENTS.md,CLAUDE.md,GEMINI.md,.agents,.cursor,.template,README.md -ErrorAction Stop |
    Where-Object { $_.Extension -in '.md','.mdc','.ps1','.sh' -and $_.Name -notin 'validate-project-truth.ps1','validate-project-truth.sh' }
$obsolete = Select-String -Path $files.FullName -Pattern '(^|[\s(`])(PRODUCT\.md|DESIGN\.md|\.project/)' -AllMatches -ErrorAction SilentlyContinue
if ($obsolete) {
    $obsolete | ForEach-Object { $_.ToString() }
    throw 'Found obsolete project-truth authority or path reference.'
}

$adoptGuidanceFiles = @(
    'AGENTS.md'
    'CLAUDE.md'
    'GEMINI.md'
    '.agents/rules/vibe-stack.md'
    '.cursor/rules/graphify.mdc'
)
foreach ($file in $adoptGuidanceFiles) {
    if (-not (Select-String -LiteralPath $file -Pattern 'adopt' -Quiet)) {
        throw "Missing adopt guidance: $file"
    }
}

Write-Output 'Project-truth structure is valid.'
