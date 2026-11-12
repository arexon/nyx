---
name: api-docs
description: "Use when you write, rewrite, or review doc comments for public APIs. Works for any language: TSDoc/JSDoc, rustdoc, and similar. Triggers: write docs, improve doc comments, add docstrings, the docs are bad or too dense. Not for README prose, internal code comments, or commit messages."
---

# API doc comments

Doc comments are for a human who uses the API. That reader wants to know what an item is, how to use it, and what can go wrong. They do not want to know how the code works inside.

Good docs are concise but informative. A type or an important function gets a few short paragraphs. A simple item gets one sentence.

Follow the `agent-style` skill for all prose.

## Shape of a doc comment

1. **Summary line.** One short sentence that says what the item is or does. It must make sense alone, because tools show it in lists and hovers.
   - Functions and methods start with a verb: "Adds plugins.", "Removes definitions."
   - Types start with a noun phrase: "A reusable group of systems and other plugins."
2. **Paragraphs.** Zero to three short paragraphs. Each paragraph has one topic: how to use the item, in which order things happen, limits, or when it fails. Keep each paragraph to about two to four sentences.
3. **Example.** Show real usage.
4. **Errors.** One short line for each error.

## Tone

A doc comment explains the item. It does not talk to the reader. Do not use "you", and do not give the reader commands. Say what the item does, what it needs, and what happens when it runs.

| Don't | Do |
|---|---|
| "You can pass a closure instead of a plugin." | "Also accepts a closure in place of a plugin." |
| "Call `build()` before you add systems." | "`addSystem()` throws if the app is not built yet." |
| "If you need lazy loading, use `LazyLoader`." | "`LazyLoader` loads the data only when it is first read." |

## Rules

- **Simple items get only the summary line.** Do not pad them with paragraphs that say the same thing again. "Loads the system's data." is a complete doc.
- **Write only what the user needs.** Leave out caches, rollback mechanics, internal state, private symbols, and the reasons for the design of the code. Say what the user sees, e.g. "If it throws, the registry stays as it was before the call."
- **Do not repeat the example.** If the example shows the steps, the calls, or the logic, the prose must not describe them again. Prose adds only what the example can't show: rules, order, limits, and reasons.
- **Do not explain the example with a comment that repeats the summary line.**
- **Do not copy one example into several docs.** Each doc gets its own example, or none.
- **Errors are short.** For an error type, write "Thrown by X when …". For a function, write one line for each error with the tag of the language. Do not document the constructor parameters of an error that only library code creates.
- **Link instead of explaining again.** If another item explains a concept, link to it.
- **Document only public items.** Do not write doc comments on private or internal items. Use a plain comment only when the reason for some code is not obvious.

## Per-language notes

| Language | Summary | Example | Errors | Links |
|---|---|---|---|---|
| TS/JS (TSDoc) | first line of `/** */` | `@example` | `@throws`, and "Thrown by …" on error types | `{@link Name}` |
| Rust | first line of `///` | `# Examples` | `# Errors`, `# Panics` | `` [`Name`] `` |

## Checklist

Before you finish, check each doc comment:

- The summary line makes sense alone.
- No prose uses "you" or gives the reader commands.
- No paragraph explains internals.
- No prose repeats the example, and no example is a copy of another doc's example.
- Simple items have only one sentence.
- Each error line is short.
- Private items have no doc comment.
